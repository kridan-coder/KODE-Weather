//
//  WindFormatter.swift
//  KODE-Weather
//
//  Created by Developer on 07.10.2021.
//

import Foundation

final class WindSpeedFormatter: Formatter {
    static func format(parameter: Double) -> String {
        let speed = Int(parameter)
        return "\(speed) \(R.string.localizable.metersPerSec())"
    }
}
