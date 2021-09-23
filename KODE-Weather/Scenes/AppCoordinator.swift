//
//  AppCoordinator.swift
//  KODE-Weather
//
//  Created by Developer on 23.09.2021.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let dependencies: AppDependencies
    
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController
    
    private let window: UIWindow
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
        
        dependencies = AppDependencies(apiClient: APIClient())
        childCoordinators = []
        navigationController = UINavigationController()
    }
    
    // MARK: - Lifecycle
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showWorldMapScene()
    }
    
    // MARK: - Private Methods
    
    private func showWorldMapScene() {
        let worldMapCoordinator = WorldMapCoordinator(dependencies: dependencies)
        
        // TODO: - Start Scene
    }
    
}
