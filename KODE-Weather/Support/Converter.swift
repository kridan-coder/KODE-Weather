//
//  Converter.swift
//  KODE-Weather
//
//  Created by Developer on 28.09.2021.
//

import Foundation
import MapKit

enum Direction: String, CaseIterable {
    case nDirection = "N",
         nneDirection = "NNE",
         neDirection = "NE",
         eneDirection = "ENE",
         eDirection = "E",
         eseDirection = "ESE",
         seDirection = "SE",
         sseDirection = "SSE",
         sDirection = "S",
         sswDirection = "SSW",
         swDirection = "SW",
         wswDirection = "WSW",
         wDirection = "W",
         wnwDirection = "WNW",
         nwDirection = "NW",
         nnwDirection = "NNW"
}

extension Direction: CustomStringConvertible  {
    init<D: BinaryFloatingPoint>(_ direction: D) {
        self = Self.allCases[Int((direction.angle + 11.25).truncatingRemainder(dividingBy: 360) / 22.5)]
    }
    var description: String { rawValue.uppercased() }
}

extension CLLocationCoordinate2D {
    var clLocation: CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}

extension BinaryFloatingPoint {
    var angle: Self {
        (truncatingRemainder(dividingBy: 360) + 360)
            .truncatingRemainder(dividingBy: 360)
    }
    var direction: Direction { .init(self) }
    var dms: (degrees: Int, minutes: Int, seconds: Int) {
        var seconds = Int(self * 3600)
        let degrees = seconds / 3600
        seconds = abs(seconds % 3600)
        return (degrees, seconds / 60, seconds % 60)
    }
}

extension CLLocation {
    var dms: String { latitude + " " + longitude }
    var latitude: String {
        let (degrees, minutes, seconds) = coordinate.latitude.dms
        return String(format: "%d°%d'%d\"%@",
                      abs(degrees), minutes, seconds, degrees >= 0
                        ? Direction.nDirection.rawValue
                        : Direction.sDirection.rawValue)
    }
    var longitude: String {
        let (degrees, minutes, seconds) = coordinate.longitude.dms
        return String(format: "%d°%d'%d\"%@",
                      abs(degrees), minutes, seconds, degrees >= 0
                        ? Direction.eDirection.rawValue
                        : Direction.wDirection.rawValue)
    }
}
