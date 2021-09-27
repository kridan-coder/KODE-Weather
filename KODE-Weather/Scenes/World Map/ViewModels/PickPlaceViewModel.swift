//
//  PickPlaceViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 27.09.2021.
//

import Foundation

class PickPlaceViewModel {
    // MARK: - Types
    
    typealias Dependencies = HasAPIClientProvider
    
    // MARK: - Properties
    
    weak var delegate: WorldMapViewModelDelegate?
    
    var mapViewModel: MapViewModel = MapViewModel()
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
}
