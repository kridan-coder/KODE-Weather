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
    
    var rootNavigationController: UINavigationController
    
    private let window: UIWindow
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
        
        dependencies = AppDependencies(apiClient: APIClient())
        childCoordinators = []
        
        rootNavigationController = UINavigationController()
        setupRootNavigationController()
    }
    
    // MARK: - Lifecycle
    
    func start() {
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        showWorldMapScene()
    }
    
    // MARK: - Private Methods
    
    private func showWorldMapScene() {
        let worldMapCoordinator = WorldMapCoordinator(dependencies: dependencies, navigationController: rootNavigationController)
        childCoordinators.append(worldMapCoordinator)
        worldMapCoordinator.start()
    }
    
    private func setupRootNavigationController() {
        rootNavigationController.navigationBar.isTranslucent = false
        rootNavigationController.navigationBar.barTintColor = .white
        rootNavigationController.navigationBar.backgroundColor = .white
        rootNavigationController.navigationBar.addShadow()
    }
    
}
