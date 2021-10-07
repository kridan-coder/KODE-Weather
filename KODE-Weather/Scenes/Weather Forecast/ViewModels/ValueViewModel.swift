//
//  DegreesViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 05.10.2021.
//

import Foundation

class ValueViewModel: WeatherForecastCellValueViewModel {
    // MARK: - Properties
    var value: String
    
    var didUpdateData: (() -> Void)?
    
    // MARK: - Init
    init(value: String) {
        self.value = value
    }
    
    // MARK: - Public Methods
    func updateData(value: String) {
        self.value = value
        self.didUpdateData?()
    }
    
}
