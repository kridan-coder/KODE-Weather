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
    
    // MARK: - Init
    init(viewModel: WeatherDetailsViewModel) {
        self.viewModel = viewModel
        self.contentView = WeatherDetailsView()
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }
    
    // MARK: - Private Methods
    private func bindToViewModel() {}
    
    private func setupView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.layoutIfNeeded()
        contentView.setup()
    }
    
}
