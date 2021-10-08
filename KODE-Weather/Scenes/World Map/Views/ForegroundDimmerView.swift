//
//  ForegroundDimmerView.swift
//  KODE-Weather
//
//  Created by Developer on 08.10.2021.
//

import UIKit

final class ForegroundDimmerView: UIView {
    // MARK: - Init
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.darkGrayColor
        layer.opacity = Constants.opacity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Constants
private extension Constants {
    static let opacity = Float(0.4)
}
