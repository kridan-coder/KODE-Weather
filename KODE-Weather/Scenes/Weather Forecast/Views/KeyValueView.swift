//
//  KeyValueView.swift
//  KODE-Weather
//
//  Created by Developer on 04.10.2021.
//

import UIKit

final class KeyValueView: UIView {
    private let keyLabel: UILabel
    private let valueLabel: UILabel
    
    // MARK: - Init
    init() {
        keyLabel = UILabel()
        valueLabel = UILabel()

        super.init(frame: CGRect.zero)
        
        initializeUI()
        createConstraints()
        
        keyLabel.text = "PRESSURE"
        valueLabel.text = "763.53 mm Hg"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func maxWidthForKeyLabel(width: Double) {
        keyLabel.snp.updateConstraints { make in
            make.width.equalTo(width)
        }
    }
    
    func maxWidthForValueLabel(width: Double) {
        valueLabel.snp.updateConstraints { make in
            make.width.equalTo(width)
        }
    }
    
    // MARK: - Private Methods
    private func initializeUI() {
        keyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        valueLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    private func createConstraints() {
        addSubview(keyLabel)
        addSubview(valueLabel)
        
//        snp.makeConstraints { make in
//            make.height.equalTo(self.snp.width)
//        }
        
        keyLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(valueLabel.snp.top).inset(-5)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
