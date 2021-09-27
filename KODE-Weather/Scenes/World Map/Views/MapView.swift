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
    
    // MARK: - Public Methods
    func configure(with viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
}
