//
//  PressureFormatter.swift
//  KODE-Weather
//
//  Created by Developer on 07.10.2021.
//

import Foundation

final class PressureFormatter: Formatter {
    static func format(parameter: Double) -> String {
        let pressure = parameter / 1.33322387415
        return String(format: "%.2f", pressure) + " " + R.string.localizable.millimetreOfMercury()
    }
}
