//
//  PickPlaceViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 27.09.2021.
//

import Foundation

class PickPlaceViewModel {
    // MARK: - Properties
    var dataUpdated: (() -> Void)?
    
    var data: PickPlaceData {
        didSet {
            dataUpdated?()
        }
    }
    
    var didPressCancelButton: (() -> Void)?
    var didPressShowWeatherButton: (() -> Void)?
    
    // MARK: - Init
    init(data: PickPlaceData) {
        self.data = data
    }
    
}
