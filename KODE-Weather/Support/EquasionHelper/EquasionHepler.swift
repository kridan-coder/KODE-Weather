//
//  EquasionHepler.swift
//  KODE-Weather
//
//  Created by Developer on 01.10.2021.
//

import Foundation
import CoreGraphics

class EquasionHelper {
    func distanceToEdgeOfCircle(axisY: Double, circle: Circumference) -> Double {
        let radiusSquared = pow(circle.radius, 2)
        let squaredDifference = pow((axisY - Double(circle.center.y)), 2)
        let substraction = radiusSquared - squaredDifference
        let squareRoot = sqrt(substraction)
        let finalResult = Double(circle.center.x) - squareRoot
        return finalResult
    }
    
}
