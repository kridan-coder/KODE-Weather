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
        
        iconView.contentMode = .scaleToFill
        iconView.kf.setImage(with: URL(string: "http://openweathermap.org/img/wn/10d@2x.png"))
        iconLabel.text = "Scattered \nClouds"
        
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func initializeUI() {
        iconLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        iconLabel.numberOfLines = 2
        iconLabel.textAlignment = .center
        

        iconView.kf.indicatorType = .activity
    }
    
    private func createConstraints() {
        addSubview(iconLabel)
        addSubview(iconView)
        //self.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom)
            make.bottom.equalToSuperview()
            
        }
        iconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(75)
        }
        

        self.sizeToFit()
    }
}
