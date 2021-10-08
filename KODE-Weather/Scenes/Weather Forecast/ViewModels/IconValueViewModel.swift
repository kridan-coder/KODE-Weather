//
//  IconValueViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 07.10.2021.
//

import Kingfisher

class IconValueViewModel: WeatherForecastCellIconValueViewModel {
    // MARK: - Types
    typealias Dependencies = HasAPIClientProvider
    
    // MARK: - Properties
    var iconLink: String
    var value: String
    
    var didUpdateData: (() -> Void)?
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies, iconID: String, value: String) {
        self.dependencies = dependencies
        self.iconLink = dependencies.apiClient.generateIconLink(iconID: iconID)
        self.value = value
    }
    
    // MARK: - Public Methods
    func updateData(iconID: String, value: String) {
        self.iconLink = dependencies.apiClient.generateIconLink(iconID: iconID)
        self.value = value
        self.didUpdateData?()
    }
    
}
