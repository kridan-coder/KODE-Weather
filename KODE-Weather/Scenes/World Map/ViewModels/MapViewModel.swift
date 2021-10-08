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
    var didReceiveData: ((PickPlaceData) -> Void)?
    var didReceiveError: ((Error) -> Void)?
    var shouldMoveToExactPlace: ((CLLocationCoordinate2D) -> Void)?
    
    private let geocoder: CLGeocoder
    
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
            
            if let safePlacemarks = placemarks, !safePlacemarks.isEmpty,
               let locationName = safePlacemarks[0].locality,
               let coordinates = safePlacemarks[0].location {
                self.didReceiveData?(PickPlaceData(placeName: locationName, placeCoordinates: coordinates.dms))
            } else {
                self.didReceiveError?(MapError.noSuchPlace)
            }
        }
    }
    
    func getDataAboutLocation(_ placeName: String) {
        geocoder.geocodeAddressString(placeName) { placemarks, error in
            if let safeError = error {
                self.didReceiveError?(safeError)
                return
            }
            
            if let safePlacemarks = placemarks, !safePlacemarks.isEmpty,
               let locationName = safePlacemarks[0].locality,
               let coordinates = safePlacemarks[0].location {
                self.didReceiveData?(PickPlaceData(placeName: locationName, placeCoordinates: coordinates.dms))
                self.shouldMoveToExactPlace?(coordinates.coordinate)
            } else {
                self.didReceiveError?(MapError.noSuchPlace)
            }
        }
    }
    
}
