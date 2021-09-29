//
//  WeatherResponse.swift
//  KODE-Weather
//
//  Created by Developer on 29.09.2021.
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: Weather
    let main: Main
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let weatherArray = try values.decode([Weather].self, forKey: .weather)
        weather = weatherArray[0]
        main = try values.decode(Main.self, forKey: .main)
    }
}
