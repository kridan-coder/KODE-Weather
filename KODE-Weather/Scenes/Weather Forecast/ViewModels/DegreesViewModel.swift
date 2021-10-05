//
//  DegreesViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 05.10.2021.
//

import Foundation

class DegreesViewModel: WeatherForecastCellViewModel {
    // MARK: - Properties
    var degrees: String {
        didSet {
            didUpdateData?()
        }
    }
    
    var didUpdateData: (() -> Void)?
    
    // MARK: - Init
    init(degrees: String) {
        self.degrees = degrees
    }
    
}
