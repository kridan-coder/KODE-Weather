//
//  WeatherDetailsViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 28.09.2021.
//

import Foundation

protocol WeatherDetailsViewModelDelegate: AnyObject {
    func weatherDetailsViewModel()
}

class WeatherDetailsViewModel {
    // MARK: - Types
    typealias Dependencies = HasAPIClientProvider
    
    // MARK: - Properties
    weak var delegate: WeatherDetailsViewModelDelegate?
    
    private let dependencies: Dependencies
    
    private var placeName: String
    
    var didStartUpdating: (() -> Void)?
    var didFinishUpdating: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    // MARK: - Init
    init(dependencies: Dependencies, placeName: String) {
        self.dependencies = dependencies
        self.placeName = placeName
    }
    
    // MARK: - Public Methods
    func reloadData() {
        self.didStartUpdating?()
        makeAPIRequest()

    }
    
    func viewWillDisappear() {
        delegate?.weatherDetailsViewModel()
    }
    
    // MARK: - Private Methods
    private func makeAPIRequest() {
        dependencies.apiClient.getWeatherInfoViaCityName(placeName) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
