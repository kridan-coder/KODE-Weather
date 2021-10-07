//
//  KeyValueViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 07.10.2021.
//

import Foundation

class KeyValueViewModel: WeatherForecastCellKeyValuesViewModel {
    // MARK: - Properties
    var key: String
    var value: String
    
    var didUpdateData: (() -> Void)?
    
    // MARK: - Init
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    // MARK: - Public Methods
    func updateData(key: String, value: String) {
        self.key = key
        self.value = value
        self.didUpdateData?()
    }
}
