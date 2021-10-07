//
//  Wind.swift
//  KODE-Weather
//
//  Created by Developer on 07.10.2021.
//

import Foundation

struct Wind: Decodable {
    let speed: Double
    let directionInDegrees: Int
    let gust: Double
    
    enum CodingKeys: String, CodingKey {
        case speed
        case directionInDegrees = "deg"
        case gust
    }
}
