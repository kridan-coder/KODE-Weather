//
//  MKMapViewAddons.swift
//  KODE-Weather
//
//  Created by Developer on 27.09.2021.
//

import Foundation
import MapKit

extension MKMapView {
  func centerToLocation(_ location: CLLocation,
                        regionRadius: CLLocationDistance = Constants.Map.defaultRadius ) {
    
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
    
}
