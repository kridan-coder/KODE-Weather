//
//  WeatherDetailsViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 28.09.2021.
//

import Foundation

protocol WeatherDetailsViewModelDelegate: AnyObject {
    func viewWillDisappear()
}

class WeatherDetailsViewModel {
    // MARK: - Types
    typealias Dependencies = HasAPIClientProvider
    
    // MARK: - Properties
    weak var delegate: WeatherDetailsViewModelDelegate?
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    func viewWillDisappear() {
        delegate?.viewWillDisappear()
    }
    
}
