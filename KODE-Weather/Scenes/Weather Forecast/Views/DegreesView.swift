//
//  DegreesView.swift
//  KODE-Weather
//
//  Created by Developer on 01.10.2021.
//

import UIKit

final class DegreesView: UIView {
    private let degreesLabelText: UILabel
    private let degreesLabelScale: UILabel

    // MARK: - Init
    init() {
        degreesLabelText = UILabel()
        degreesLabelScale = UILabel()

        super.init(frame: CGRect.zero)
        
        initializeUI()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func initializeUI() {
        
        degreesLabelText.font = UIFont.systemFont(ofSize: 100, weight: .bold)
        degreesLabelText.numberOfLines = 1
        
        degreesLabelText.textColor = UIColor(red: 0.21, green: 0.21, blue: 0.21, alpha: 1)
       
        //rgba(53, 53, 53, 1)
        
        degreesLabelText.text = "-23"

        degreesLabelScale.text = "°C"
        degreesLabelScale.font = UIFont.systemFont(ofSize: 35, weight: .regular)
        degreesLabelScale.textColor = UIColor(red: 0.21, green: 0.21, blue: 0.21, alpha: 1)
    }
    private func createConstraints() {
        addSubview(degreesLabelText)
        addSubview(degreesLabelScale)
        
        
        degreesLabelText.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(degreesLabelScale.snp.leading)
        }
        degreesLabelScale.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.trailing)
            make.bottom.lessThanOrEqualToSuperview()
            make.top.equalTo(degreesLabelText)
        }
    }
}
