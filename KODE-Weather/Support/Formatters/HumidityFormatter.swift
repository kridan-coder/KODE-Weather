//
//  HumidityFormatter.swift
//  KODE-Weather
//
//  Created by Developer on 07.10.2021.
//

import Foundation

final class HumidityFormatter: Formatter {
    static func format(parameter: Double) -> String {
        return "\(Int(parameter))%"
    }
}
