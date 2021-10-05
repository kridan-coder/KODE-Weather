//
//  WeatherForecastCoordinator.swift
//  KODE-Weather
//
//  Created by Developer on 23.09.2021.
//

import UIKit

class WeatherForecastCoordinator: Coordinator {
    // MARK: - Types
    typealias Dependencies = HasAPIClientProvider
    
    // MARK: - Properties
    weak var delegate: WorldMapCoordinator?
    
    var childCoordinators: [Coordinator]
    
    var rootNavigationController: UINavigationController
    
    var placeName: String
    
    private let dependencies: Dependencies
    
    // MARK: - IBOutlets (всегда приватные)
    
    // MARK: - Init
    init(placeName: String, dependencies: Dependencies, navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.childCoordinators = []
        self.rootNavigationController = navigationController
        self.placeName = placeName
    }
    
    // MARK: - Lifecycle
    func start() {
        let weatherDetailsViewModel = WeatherDetailsViewModel(dependencies: dependencies, placeName: placeName)
        weatherDetailsViewModel.delegate = self
        
        let weatherDetailsViewController = WeatherDetailsViewController(viewModel: weatherDetailsViewModel)
        weatherDetailsViewController.title = placeName
        
        rootNavigationController.navigationBar.prefersLargeTitles = true
        rootNavigationController.navigationBar.hideShadow()
        rootNavigationController.pushViewController(weatherDetailsViewController, animated: true)
    }
    // MARK: - Public Methods
    // MARK: - Actions (@ojbc + @IBActions)
    // MARK: - Private Methods
}

// MARK: - WeatherDetailsViewModelDelegate
extension WeatherForecastCoordinator: WeatherDetailsViewModelDelegate {
    func weatherDetailsViewModel() {
        rootNavigationController.navigationBar.prefersLargeTitles = false
        rootNavigationController.navigationBar.showShadow()
    }
}
