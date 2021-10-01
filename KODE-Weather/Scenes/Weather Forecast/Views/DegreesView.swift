//
//  DegreesView.swift
//  KODE-Weather
//
//  Created by Developer on 01.10.2021.
//

import UIKit

final class DegreesView: UIView {
    private let degreesLabel: UILabel
    
    // MARK: - Init
    init() {
        degreesLabel = UILabel()

        super.init(frame: CGRect.zero)
        
        initializeUI()
        createConstraints()
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func initializeUI() {
        degreesLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
    }
    private func createConstraints() {
        addSubview(degreesLabel)
        degreesLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
