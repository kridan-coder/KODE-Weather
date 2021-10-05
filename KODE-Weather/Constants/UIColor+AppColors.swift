//
//  UIColor+AppColors.swift
//  KODE-Weather
//
//  Created by Developer on 27.09.2021.
//

import UIKit

extension UIColor {
    static var shadowColor: UIColor {
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            return UIColor.black
        } else {
            return UIColor.lightGray
        }
    }
    
    static var mainColor: UIColor {
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            return UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1)
        } else {
            return UIColor.white
        }
    }
    
    static var secondaryColor: UIColor {
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0.60)
        } else {
            return UIColor.darkGray
        }
    }
    
    static var accentColor: UIColor {
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0.87)
        } else {
            return UIColor(red: 0.29, green: 0.56, blue: 0.89, alpha: 1)
        }
    }
    
    static var darkGrayColor: UIColor {
        return .darkGray
    }
}
