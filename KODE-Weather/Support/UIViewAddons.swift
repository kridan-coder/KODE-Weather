//
//  UIViewAddons.swift
//  KODE-Weather
//
//  Created by Developer on 27.09.2021.
//

import UIKit

extension UIView {
    func addShadow(color: CGColor = Constants.Shadow.defaultColor,
                   opacity: Float = Constants.Shadow.defaultOpacity,
                   offset: CGFloat = Constants.Shadow.defaultOffset,
                   radius: CGFloat = Constants.Shadow.defaultRadius) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: offset)
        self.layer.shadowRadius = radius
    }
}

private extension Constants {
    struct Shadow {
        static let defaultColor = UIColor.shadowColor.cgColor
        static let defaultOpacity = Float(0.4)
        static let defaultOffset = CGFloat(7.0)
        static let defaultRadius = CGFloat(3)
    }
}
