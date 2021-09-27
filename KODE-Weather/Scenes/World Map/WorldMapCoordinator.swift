//
//  WorldMapCoordinator.swift
//  KODE-Weather
//
//  Created by Developer on 23.09.2021.
//

import UIKit

class WorldMapCoordinator: Coordinator {
    // MARK: - Types
    
    typealias Dependencies = HasAPIClientProvider
    
    // MARK: - Properties
    
    var childCoordinators: [Coordinator]
    
    var rootNavigationController: UINavigationController
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    
    init(dependencies: Dependencies, navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.childCoordinators = []
        self.rootNavigationController = navigationController
    }
    
    // MARK: - Lifecycle
    
    func start() {
        let worldMapViewModel = WorldMapViewModel(dependencies: dependencies)
        worldMapViewModel.delegate = self
        
        let worldMapViewController = WorldMapViewController(viewModel: worldMapViewModel)
        worldMapViewController.title = R.string.localizable.globalWeather()
        
        rootNavigationController.setViewControllers([worldMapViewController], animated: false)
    }
    
    // MARK: - Public Methods
    // MARK: - Private Methods

}

// MARK: - WorldMapViewModelDelegate
extension WorldMapCoordinator: WorldMapViewModelDelegate {}
