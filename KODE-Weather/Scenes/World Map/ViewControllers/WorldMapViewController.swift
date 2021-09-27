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
    
    private let searchController: UISearchController
    
    // MARK: - Init
    
    init(viewModel: WorldMapViewModel) {
        self.viewModel = viewModel
        
        mapView = MapView()
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
    }
    
    // MARK: - Public Methods
    
    // MARK: - Actions
    
    @IBAction func getCoordinatePressOnMap(sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
        setupMapView()
        
        let pickPlaceView = PickPlaceView()
        view.addSubview(pickPlaceView)
        pickPlaceView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(3.5)
        }
        pickPlaceView.showWeatherButton.setTitle("Show Weather", for: .normal)
        pickPlaceView.placeNameLabel.text = "Amsterdam"
        pickPlaceView.placeCoordinatesLabel.text = "45°16'44.7\"N 9°43'33.2\"E"
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mapView.setCameraZoomRange(Constants.Map.maximumZoomRange, animated: false)
        mapView.centerToLocation(Constants.Map.initialLocation)
        mapView.showsUserLocation = true
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
