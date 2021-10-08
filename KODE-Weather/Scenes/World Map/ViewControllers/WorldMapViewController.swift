//
//  WorldMapViewController.swift
//  KODE-Weather
//
//  Created by Developer on 24.09.2021.
//

import UIKit
import MapKit
import SnapKit

class WorldMapViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: WorldMapViewModel
    
    private let mapView: MapView
    private let pickPlaceView: PickPlaceView
    private let foregroundDimmerView: ForegroundDimmerView
    private let activityIndicator: UIActivityIndicatorView
    private let searchController: UISearchController
    
    // MARK: - Init
    init(viewModel: WorldMapViewModel) {
        self.viewModel = viewModel
        
        mapView = MapView()
        pickPlaceView = PickPlaceView()
        foregroundDimmerView = ForegroundDimmerView()
        searchController = UISearchController()
        activityIndicator = UIActivityIndicatorView(style: .large)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSearchController()
        setupGestureRecognizerForMap()
        bindToViewModel()
        
        navigationItem.backButtonTitle = R.string.localizable.map()
    }
    
    // MARK: - Actions
    @IBAction private func tappedOnMap(sender: UITapGestureRecognizer) {
        startLoading()
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        viewModel.tappedAtLocation(locationCoordinate.clLocation)
    }
    
    // MARK: - Private Methods
    private func tappedAtSearchButton(with placeName: String) {
        startLoading()
        viewModel.tappedAtSearchButton(with: placeName)
    }
    
    private func bindToViewModel() {
        viewModel.didFindPlace = { [weak self] in
            self?.showPickPlaceView()
            self?.stopLoading()
        }
        viewModel.needsPickPlaceViewHidden = { [weak self] in
            self?.hidePickPlaceView()
        }
        viewModel.didReceiveError = { [weak self] error in
            self?.showAlertWithError(error)
            self?.stopLoading()
        }
    }
    
    private func showAlertWithError(_ error: Error) {
        let title: String
        if let customError = error as? CustomError {
            title = customError.errorTitle
        } else {
            title = R.string.localizable.defaultErrorTitle()
        }
        let alert = UIAlertController.buildAlertWithOneButton(title: title, message: error.localizedDescription)
        present(alert, animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .mainColor
        setupMapView()
        setupPickPlaceView()
        setupActivityIndicatorView()
        setupForegroundDimmerView()
    }
    
    private func startLoading() {
        blockUserInteraction()
        activityIndicator.startAnimating()
        foregroundDimmerView.isHidden = false
        navigationController?.navigationBar.layer.opacity = Constants.NavigationBar.opacityOnLoading
    }
    
    private func stopLoading() {
        allowUserInteraction()
        activityIndicator.stopAnimating()
        foregroundDimmerView.isHidden = true
        navigationController?.navigationBar.layer.opacity = Constants.NavigationBar.opacityDefault
    }
    
    private func showPickPlaceView() {
        UIView.animate(withDuration: Constants.PickPlaceView.animationDuration) {
            self.pickPlaceView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(Constants.PickPlaceView.insetDefault)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func hidePickPlaceView() {
        UIView.animate(withDuration: Constants.PickPlaceView.animationDuration) {
            self.pickPlaceView.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.snp.bottom).inset(-Constants.PickPlaceView.insetHidden)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func setupGestureRecognizerForMap() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedOnMap(sender:)))
        gestureRecognizer.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func blockUserInteraction() {
        view.isUserInteractionEnabled = false
        navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    
    private func allowUserInteraction() {
        view.isUserInteractionEnabled = true
        navigationController?.navigationBar.isUserInteractionEnabled = true
    }
    
    // Setup Views
    private func setupActivityIndicatorView() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupForegroundDimmerView() {
        foregroundDimmerView.isHidden = true
        view.addSubview(foregroundDimmerView)
        foregroundDimmerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupPickPlaceView() {
        view.addSubview(pickPlaceView)
        pickPlaceView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.PickPlaceView.insetDefault)
            make.bottom.equalTo(view.snp.bottom).inset(-Constants.PickPlaceView.insetHidden)
            make.height.greaterThanOrEqualToSuperview().dividedBy(Constants.PickPlaceView.heightDivision)
        }
        pickPlaceView.configure(with: viewModel.pickPlaceViewModel)
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mapView.configure(with: viewModel.mapViewModel)
    }
    
}

// MARK: - UISearchBarDelegate
extension WorldMapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            hideSearchBar(withPlaceholder: text)
            tappedAtSearchButton(with: text)
        }
    }
    
    // SearchBar Helpers
    private func hideSearchBar(withPlaceholder placeholder: String?) {
        searchController.searchBar.placeholder = placeholder
        searchController.searchBar.showsScopeBar = false
        searchController.searchBar.endEditing(true)
        searchController.isActive = false
    }
    
}

// MARK: - Constants
private extension Constants {
    struct NavigationBar {
        static let opacityOnLoading = Float(0.8)
        static let opacityDefault = Float(1)
    }
    
    struct PickPlaceView {
        static let insetDefault = CGFloat(20)
        static let insetHidden = CGFloat(300)
        
        static let heightDivision = CGFloat(3.5)
        
        static let animationDuration = 0.3
    }
    
}
