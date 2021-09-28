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
    
    private let searchController: UISearchController
    
    private var pickViewIsShown = false
    
    // MARK: - Init
    
    init(viewModel: WorldMapViewModel) {
        self.viewModel = viewModel
        
        mapView = MapView()
        pickPlaceView = PickPlaceView()
        searchController = UISearchController()
        
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
    }
    
    // MARK: - Public Methods
    
    // MARK: - Actions
    
    @IBAction private func getCoordinatePressOnMap(sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        viewModel.tappedAtLocation(locationCoordinate.clLocation)
        self.pickViewIsShown = true

    }
    
    // MARK: - Private Methods
    
    private func bindToViewModel() {
        viewModel.didFindPlace = { [weak self] in
            self?.showPickPlaceView()
        }
        viewModel.needsPickPlaceViewHidden = { [weak self] in
            self?.hidePickPlaceView()
        }
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
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getCoordinatePressOnMap(sender:)))
        gestureRecognizer.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
}

extension WorldMapViewController: UISearchControllerDelegate {}
