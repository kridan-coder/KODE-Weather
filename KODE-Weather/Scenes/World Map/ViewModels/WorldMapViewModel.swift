//
//  WorldMapViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 24.09.2021.
//

import Foundation
import MapKit

protocol WorldMapViewModelDelegate: AnyObject {
    func worldMapViewModel(_ worldMapViewModel: WorldMapViewModel, didRequestShowWeatherFor placeName: String)
}

class WorldMapViewModel {
    // MARK: - Types
    typealias Dependencies = HasAPIClientProvider
    
    // MARK: - Properties
    weak var delegate: WorldMapViewModelDelegate?
    
    var mapViewModel: MapViewModel
    var pickPlaceViewModel: PickPlaceViewModel
    
    var didStartUpdating: (() -> Void)?
    var didFindPlace: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    var needsPickPlaceViewHidden: (() -> Void)?
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        
        mapViewModel = MapViewModel()
        pickPlaceViewModel = PickPlaceViewModel(data: PickPlaceData())
        
        bindToMapViewModel()
        bindToPickPlaceViewModel()
    }
    
    // MARK: - Public Methods
    func tappedAtLocation(_ location: CLLocation) {
        self.didStartUpdating?()
        mapViewModel.getDataAboutLocation(location)
    }
    
    func tappedAtSearchButton(with placeName: String) {
        self.didStartUpdating?()
        mapViewModel.getDataAboutLocation(placeName)
    }
    
    // MARK: - Private Methods
    private func bindToMapViewModel() {
        mapViewModel.didReceiveData = { data in
            self.pickPlaceViewModel.data = data
            self.didFindPlace?()
        }
        
        mapViewModel.didReceiveError = { error in
            self.didReceiveError?(error)
        }
    }
    
    private func bindToPickPlaceViewModel() {
        pickPlaceViewModel.didPressCancelButton = {
            self.needsPickPlaceViewHidden?()
        }
        pickPlaceViewModel.didPressShowWeatherButton = {
            self.delegate?.worldMapViewModel(self, didRequestShowWeatherFor: self.pickPlaceViewModel.data.placeName)
        }
    }
    
}
