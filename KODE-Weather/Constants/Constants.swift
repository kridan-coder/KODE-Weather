//
//  Constants.swift
//  KODE-Weather
//
//  Created by Developer on 27.09.2021.
//

import Foundation
import CoreLocation
import CoreGraphics
import MapKit

struct Constants {
    struct Map {
        static let initialLocation = CLLocation(latitude: 52.377956, longitude: 4.897070)
        static let defaultRadius = CLLocationDistance(5000)
        static let maximumZoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 1000000)
    }
    
}
