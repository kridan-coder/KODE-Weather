//
//  AppCoordinator.swift
//  KODE-Weather
//
//  Created by Developer on 23.09.2021.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController = UINavigationController()
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showWorldMapScene()
    }
    
    private func showWorldMapScene() {
        // TODO: - create and start Scene
    }
    
}
