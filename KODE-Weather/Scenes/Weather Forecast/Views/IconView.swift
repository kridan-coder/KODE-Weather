//
//  IconView.swift
//  KODE-Weather
//
//  Created by Developer on 01.10.2021.
//

import UIKit
import Kingfisher

final class IconView: UIView {
    private let iconLabel: UILabel
    private let iconView: UIImageView
    
    // MARK: - Init
    init() {
        iconLabel = UILabel()
        iconView = UIImageView()

        super.init(frame: CGRect.zero)
        
        initializeUI()
        createConstraints()
        
        iconLabel.text = "Scattered Clouds"
        iconView.kf.setImage(with: URL(string: "http://openweathermap.org/img/wn/10d@2x.png"))
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func initializeUI() {
        iconLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        iconLabel.numberOfLines = 2
        
        iconView.kf.indicatorType = .activity
    }
    
    private func createConstraints() {
        addSubview(iconLabel)
        addSubview(iconView)
        
        iconLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        iconView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
    }
}
