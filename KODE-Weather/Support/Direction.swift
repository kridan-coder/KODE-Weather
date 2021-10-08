//
//  Direction.swift
//  KODE-Weather
//
//  Created by Developer on 08.10.2021.
//

import Foundation

enum Direction: String, CaseIterable {
    case nDirection,
         nneDirection,
         neDirection,
         eneDirection,
         eDirection,
         eseDirection,
         seDirection,
         sseDirection,
         sDirection,
         sswDirection,
         swDirection,
         wswDirection,
         wDirection,
         wnwDirection,
         nwDirection,
         nnwDirection
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
}

extension Direction: CustomStringConvertible {
    init<D: BinaryFloatingPoint>(_ direction: D) {
        self = Self.allCases[Int((direction.angle + 11.25).truncatingRemainder(dividingBy: 360) / 22.5)]
    }
    var description: String { localizedString }
    
}
