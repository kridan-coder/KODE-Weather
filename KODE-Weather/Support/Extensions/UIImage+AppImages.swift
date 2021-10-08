//
//  UIImage+AppImages.swift
//  KODE-Weather
//
//  Created by Developer on 27.09.2021.
//

import UIKit

extension UIImage {
    static let cancel = UIImage(named: "CancelButton")?.withTintColor(UIColor.accentColor, renderingMode: .alwaysTemplate)
    
    static let scatteredClouds = UIImage(named: "ScatteredClouds")
    static let clearSky = UIImage(named: "ClearSky")
    static let rain = UIImage(named: "Rain")
    static let thunderStorm = UIImage(named: "ThunderStorm")
    static let fewClouds = UIImage(named: "FewClouds")
    static let brokenClouds = UIImage(named: "BrokenClouds")
    static let showerRain = UIImage(named: "ShowerRain")
    static let snow = UIImage(named: "Snow")
    static let mist = UIImage(named: "Mist")
}
