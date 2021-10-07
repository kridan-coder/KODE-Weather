//
//  StringAddons.swift
//  KODE-Weather
//
//  Created by Developer on 07.10.2021.
//

import Foundation

extension String {
    func newLineAfterEveryWord() -> String {
        return self.replacingOccurrences(of: " ", with: "\n")
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
