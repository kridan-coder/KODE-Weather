//
//  CLLocation+BinaryFloatingPointAddons.swift
//  KODE-Weather
//
//  Created by Developer on 28.09.2021.
//

import Foundation
import MapKit

extension CLLocation {
    var dms: String { latitude + " " + longitude }
    var latitude: String {
        let (degrees, minutes, seconds) = coordinate.latitude.dms
        return String(format: "%d°%d'%d\"%@",
                      abs(degrees), minutes, seconds, degrees >= 0
                        ? Direction.nDirection.localizedString
                        : Direction.sDirection.localizedString)
    }
    var longitude: String {
        let (degrees, minutes, seconds) = coordinate.longitude.dms
        return String(format: "%d°%d'%d\"%@",
                      abs(degrees), minutes, seconds, degrees >= 0
                        ? Direction.eDirection.localizedString
                        : Direction.wDirection.localizedString)
    }
    
}

extension BinaryFloatingPoint {
    var angle: Self {
        (truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
    }
    var direction: Direction { .init(self) }
    var dms: (degrees: Int, minutes: Int, seconds: Int) {
        var seconds = Int(self * 3600)
        let degrees = seconds / 3600
        seconds = abs(seconds % 3600)
        return (degrees, seconds / 60, seconds % 60)
    }
    
}

extension CLLocationCoordinate2D {
    var clLocation: CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
}
