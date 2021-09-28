//
//  MapViewModel.swift
//  KODE-Weather
//
//  Created by Developer on 24.09.2021.
//

import Foundation
import MapKit

final class MapViewModel {
    // MARK: - Properties
    private let geocoder: CLGeocoder
    
    var didReceiveData: ((PickPlaceData) -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    // MARK: - Init
    init() {
        geocoder = CLGeocoder()
    }
    
    // MARK: - Public Methods
    func getDataAboutLocation(_ location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let safeError = error {
                self.didReceiveError?(safeError)
                return
            }
            
            if let safePlacemarks = placemarks,
               let locationName = safePlacemarks[0].locality,
               let coordinates = safePlacemarks[0].location {
                
                self.didReceiveData?(PickPlaceData(placeName: locationName, placeCoordinates: coordinates.dms))
            } else {
                self.didReceiveError?(MapError.noSuchPlace)
            }
            
        }
    }
    
}
