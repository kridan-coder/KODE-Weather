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
    var childCoordinators: [Coordinator]
    
    var rootNavigationController: UINavigationController
    
    private let dependencies: Dependencies
    
    // MARK: - IBOutlets (всегда приватные)
    
    // MARK: - Init
    init(dependencies: Dependencies, navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.childCoordinators = []
        self.rootNavigationController = navigationController
    }
    
    // MARK: - Lifecycle
    func start() {
        let weatherDetailsViewModel = WeatherDetailsViewModel(dependencies: dependencies)
        weatherDetailsViewModel.delegate = self
        
        let weatherDetailsViewController = WeatherDetailsViewController(viewModel: weatherDetailsViewModel)
        weatherDetailsViewController.title = R.string.localizable.globalWeather()
        
        rootNavigationController.pushViewController(weatherDetailsViewController, animated: true)
    }
    // MARK: - Public Methods
    // MARK: - Actions (@ojbc + @IBActions)
    // MARK: - Private Methods
}

// MARK: - WeatherDetailsViewModelDelegate
extension WeatherForecastCoordinator: WeatherDetailsViewModelDelegate {}
