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
    
    private let mapView: MKMapView
    private let pickPlaceView: PickPlaceView
    
    private let activityIndicator: UIActivityIndicatorView
    private let foregroundView: UIView
    
    private let searchController: UISearchController
    
    private var pickViewIsShown = false
    
    // MARK: - Init
    
    init(viewModel: WorldMapViewModel) {
        self.viewModel = viewModel
        
        mapView = MapView()
        pickPlaceView = PickPlaceView()
        searchController = UISearchController()
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        foregroundView = {
            let view = UIView()
            view.backgroundColor = .darkGray
            view.layer.opacity = 0.4
            view.isHidden = true
            return view
        }()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = R.string.localizable.map()
        setupView()
        setupSearchController()
        setupGestureRecognizerForMap()
        bindToViewModel()
    }
    
    // MARK: - Public Methods
    
    // MARK: - Actions
    
    @IBAction private func tappedOnMap(sender: UITapGestureRecognizer) {
        startLoading()
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        viewModel.tappedAtLocation(locationCoordinate.clLocation)
        self.pickViewIsShown = true

    }
    
    // MARK: - Private Methods
    
    private func bindToViewModel() {
        viewModel.didFindPlace = { [weak self] in
            self?.showPickPlaceView()
            self?.stopLoading()
            
        }
        viewModel.needsPickPlaceViewHidden = { [weak self] in
            self?.hidePickPlaceView()
        }
    }
    
    private func blockUserInteraction() {
        view.isUserInteractionEnabled = false
        navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    
    private func allowUserInteraction() {
        view.isUserInteractionEnabled = true
        navigationController?.navigationBar.isUserInteractionEnabled = true
    }
    
    private func startLoading() {
        blockUserInteraction()
        activityIndicator.startAnimating()
        navigationController?.navigationBar.layer.opacity = 0.8
        foregroundView.isHidden = false
    }
    
    private func stopLoading() {
        allowUserInteraction()
        activityIndicator.stopAnimating()
        foregroundView.isHidden = true
        navigationController?.navigationBar.layer.opacity = 1
    }
    
    private func showPickPlaceView() {
        UIView.animate(withDuration: 0.3) {
            self.pickPlaceView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(20)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func hidePickPlaceView() {
        UIView.animate(withDuration: 0.3) {
            self.pickPlaceView.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.snp.bottom).inset(-300)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .mainColor
        setupMapView()
        setupPickPlaceView()
        setupActivityIndicatorView()
        setupForegroundView()
    }
    
    private func setupActivityIndicatorView() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupForegroundView() {
        view.addSubview(foregroundView)
        foregroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupPickPlaceView() {
        view.addSubview(pickPlaceView)
        pickPlaceView.configure(with: viewModel.pickPlaceViewModel)
        pickPlaceView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.snp.bottom).inset(-300)
            make.height.greaterThanOrEqualToSuperview().dividedBy(3.5)
        }
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.delegate = self
    }
    
    private func setupGestureRecognizerForMap() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedOnMap(sender:)))
        gestureRecognizer.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
}

extension WorldMapViewController: UISearchControllerDelegate {}
