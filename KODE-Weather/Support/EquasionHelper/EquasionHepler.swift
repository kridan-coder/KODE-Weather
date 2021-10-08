//
//  EquasionHepler.swift
//  KODE-Weather
//
//  Created by Developer on 01.10.2021.
//

import Foundation
import CoreGraphics

final class EquasionHelper {
    static func distanceToEdgeOfCircle(axisY: CGFloat, circle: Circumference) -> Double {
        let radiusSquared = CGFloat(pow(circle.radius, 2))
        let squaredDifference = pow((axisY - circle.center.y), 2)
        let substraction = radiusSquared - squaredDifference
        let squareRoot = sqrt(substraction)
        let finalResult = Double(circle.center.x - squareRoot)
        return finalResult
    }
    
}
