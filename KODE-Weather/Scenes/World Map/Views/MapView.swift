//
//  MapView.swift
//  KODE-Weather
//
//  Created by Developer on 24.09.2021.
//

import UIKit
import MapKit

final class MapView: MKMapView {
    // MARK: - Properties
    private var viewModel: MapViewModel?
    
    // MARK: - Init
    init() {
        super.init(frame: CGRect.zero)
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Private Methods
    private func setupMapView() {
        setCameraZoomRange(Constants.Map.maximumZoomRange, animated: false)
        centerToLocation(Constants.Map.initialLocation)
    }
}
