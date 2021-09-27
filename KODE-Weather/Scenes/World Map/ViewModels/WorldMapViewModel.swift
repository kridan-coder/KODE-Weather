//
//  WorldMapViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 24.09.2021.
//

import Foundation

protocol WorldMapViewModelDelegate: AnyObject {
    // TODO: setup delegate logic
}

class WorldMapViewModel {
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
