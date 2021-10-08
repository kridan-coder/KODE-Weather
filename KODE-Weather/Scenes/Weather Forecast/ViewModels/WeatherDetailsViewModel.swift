//
//  WeatherDetailsViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 28.09.2021.
//

import Foundation

protocol WeatherDetailsViewModelDelegate: AnyObject {
    func weatherDetailsViewModelWillDisappear()
}

class WeatherDetailsViewModel {
    // MARK: - Types
    typealias Dependencies = HasAPIClientProvider
    
    // MARK: - Properties
    weak var delegate: WeatherDetailsViewModelDelegate?
    
    var cellViewModels: [WeatherForecastCellViewModel]
    
    var placeName: String
    var weatherID: Int
    
    var didStartUpdating: (() -> Void)?
    var didFinishUpdating: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies, placeName: String) {
        self.dependencies = dependencies
        self.placeName = placeName
        cellViewModels = []
        weatherID = 0
    }
    
    // MARK: - Public Methods
    func reloadData() {
        self.didStartUpdating?()
        makeAPIRequest()
    }
    
    func viewWillDisappear() {
        delegate?.weatherDetailsViewModelWillDisappear()
    }
    
    // MARK: - Private Methods
    private func makeAPIRequest() {
        dependencies.apiClient.getWeatherInfoViaCityName(placeName) { result in
            switch result {
            case .success(let response):
                self.setupWeatherIDAccordingToResponse(response)
                self.setupViewModelsAccordingToResponse(response)
                self.didFinishUpdating?()
            case .failure(let error):
                self.didReceiveError?(error)
            }
        }
    }
    
    private func setupWeatherIDAccordingToResponse(_ response: WeatherResponse) {
        if let weatherID = response.weather?.id {
            self.weatherID = weatherID
        }
    }
    
    private func setupViewModelsAccordingToResponse(_ response: WeatherResponse) {
        cellViewModels = []
        
        if let temperature = response.main?.temperature {
            cellViewModels.append(ValueViewModel(value: String(Int(temperature))))
        }
        
        if let iconContainer = response.weather {
            cellViewModels.append(IconValueViewModel(dependencies: dependencies,
                                                     iconID: iconContainer.icon,
                                                     value: iconContainer.description
                                                        .capitalizingFirstLetter()
                                                        .newLineAfterEveryWord()))
        }
        
        if let humidity = response.main?.humidity {
            cellViewModels.append(KeyValueViewModel(key: R.string.localizable.humidity(),
                                                    value: HumidityFormatter.format(parameter: Double(humidity))))
        }
        
        tryToBuildWindViewModel(with: response)
        
        if let pressure = response.main?.pressure {
            cellViewModels.append(KeyValueViewModel(key: R.string.localizable.pressure(),
                                                    value: PressureFormatter.format(parameter: Double(pressure))))
        }
    }
    
    private func tryToBuildWindViewModel(with response: WeatherResponse) {
        if let windSpeed = response.wind?.speed {
            var windDirectionString = ""
            if let windDirection = response.wind?.directionInDegrees {
                windDirectionString += WindDirectionFormatter.format(parameter: Double(windDirection)) + " "
            }
            cellViewModels.append(KeyValueViewModel(key: R.string.localizable.wind(),
                                                    value: windDirectionString
                                                        + WindSpeedFormatter.format(parameter: windSpeed)))
        }
    }
    
}
