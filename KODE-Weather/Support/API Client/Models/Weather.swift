//
//  Weather.swift
//  KODE-Weather
//
//  Created by Developer on 29.09.2021.
//

import Foundation

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
