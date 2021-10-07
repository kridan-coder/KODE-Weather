//
//  Main.swift
//  KODE-Weather
//
//  Created by Developer on 29.09.2021.
//

import Foundation

struct Main: Decodable {
    let temperature: Double
    let humidity: Int
    let pressure: Int
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
        case pressure
    }
}
