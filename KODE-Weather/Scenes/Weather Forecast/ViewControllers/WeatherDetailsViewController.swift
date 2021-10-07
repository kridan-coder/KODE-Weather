//
//  WeatherDetailsViewController.swift
//  KODE-Weather
//
//  Created by Developer on 28.09.2021.
//

import UIKit

final class WeatherDetailsViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: WeatherDetailsViewModel
    
    private let contentView: WeatherDetailsView
    
    private var stackViewSubviews: [UIView]
    
    // MARK: - Init
    init(viewModel: WeatherDetailsViewModel) {
        self.viewModel = viewModel
        self.contentView = WeatherDetailsView()
        self.stackViewSubviews = []
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        viewModel.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }
    
    // MARK: - Private Methods
    private func bindToViewModel() {
        viewModel.didFinishUpdating = { [weak self] in
            self?.setupBigImage()
            self?.setupCells()
            self?.stopLoading()
        }
        viewModel.didReceiveError = { [weak self] error in
            self?.showAlertWithError(error)
        }
    }
    
    private func showAlertWithError(_ error: Error) {
        
        let title: String
        if let customError = error as? CustomError {
            title = customError.errorTitle
            
        } else {
            title = R.string.localizable.defaultErrorTitle()
        }
        let alert = UIAlertController.buildWithOkayButton(title: title,
                                                          message: error.localizedDescription) { alertAction in
            self.navigationController?.popViewController(animated: true)
        }
        present(alert, animated: true)
    }
    
    private func stopLoading() {
        contentView.finishedLoadingData()
    }
    
    private func setupBigImage() {
        let image: UIImage?
        switch viewModel.weatherID {
        case 200...232:
            image = .thunderStorm
        case 300...321:
            image = .showerRain
        case 500...504:
            image = .rain
        case 511:
            image = .snow
        case 520...531:
            image = .showerRain
        case 600...622:
            image = .snow
        case 701...781:
            image = .mist
        case 800:
            image = .clearSky
        case 801:
            image = .fewClouds
        case 802:
            image = .scatteredClouds
        case 803...804:
            image = .brokenClouds
        default:
            image = .scatteredClouds
        }
        contentView.setupBigImageView(with: image)
    }
    
    private func setupCells() {
        stackViewSubviews = []
        for viewModel in viewModel.cellViewModels {
            switch viewModel {
            case let valueViewModel as ValueViewModel:
                let valueView = ValueView()
                valueView.configure(with: valueViewModel)
                stackViewSubviews.append(valueView)
            case let iconValueViewModel as IconValueViewModel:
                let iconValueView = IconValueView()
                iconValueView.configure(with: iconValueViewModel)
                stackViewSubviews.append(iconValueView)
            case let keyValueViewModel as KeyValueViewModel:
                let keyValueView = KeyValueView()
                keyValueView.configure(with: keyValueViewModel)
                stackViewSubviews.append(keyValueView)
            default: break
            }
        }
        contentView.setupStackViewSubviews(with: stackViewSubviews)
           
    }
    
    private func setupView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.layoutIfNeeded()
        contentView.setup()
    }
    
}
