//
//  WeatherForecastCellViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 05.10.2021.
//

import Foundation

protocol WeatherForecastCellViewModel {}

protocol WeatherForecastCellValueViewModel: WeatherForecastCellViewModel {
    var value: String { get }
}

protocol WeatherForecastCellIconValueViewModel: WeatherForecastCellViewModel {
    var iconLink: String { get }
    var value: String { get }
}

protocol WeatherForecastCellKeyValuesViewModel: WeatherForecastCellViewModel {
    var key: String { get }
    var value: String { get }
}
