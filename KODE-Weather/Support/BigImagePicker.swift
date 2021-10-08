//
//  BigImagePicker.swift
//  KODE-Weather
//
//  Created by Developer on 08.10.2021.
//

import UIKit

final class BigImagePicker {
    static func pickImageAccordingToWeatherID(_ weatherID: Int) -> UIImage? {
        let image: UIImage?
        switch weatherID {
        case 200...232:
            image = .thunderStorm
        case 300...321:
            image = .showerRain
        case 500...504:
            image = .rain
        case 511:
            image = .snow
        case 520...531:
            image = .showerRain
        case 600...622:
            image = .snow
        case 701...781:
            image = .mist
        case 800:
            image = .clearSky
        case 801:
            image = .fewClouds
        case 802:
            image = .scatteredClouds
        case 803...804:
            image = .brokenClouds
        default:
            image = .scatteredClouds
        }
        return image
    }
    
}
