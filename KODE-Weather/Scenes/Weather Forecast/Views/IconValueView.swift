//
//  IconView.swift
//  KODE-Weather
//
//  Created by Developer on 01.10.2021.
//

import UIKit
import Kingfisher

final class IconValueView: UIView {
    // MARK: - Properties
    private var viewModel: IconValueViewModel?
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: IconValueViewModel) {
        self.viewModel = viewModel
        iconView.kf.setImage(with: URL(string: viewModel.iconLink))
        iconLabel.text = viewModel.value
        
        viewModel.didUpdateData = {
            self.iconView.kf.setImage(with: URL(string: viewModel.iconLink))
            self.iconLabel.text = viewModel.value
        }
    }
    
    // MARK: - Private Methods
    private func initializeUI() {
        iconLabel.font = .mini
        iconLabel.numberOfLines = Constants.defaultLabelLinesAmount
        iconLabel.textAlignment = .center
        iconView.kf.indicatorType = .activity
    }
    
    private func createConstraints() {
        addSubview(iconLabel)
        addSubview(iconView)
        iconLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom)
            make.bottom.equalToSuperview()
            
        }
        iconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(Constants.defaultIconSize)
        }
        
        self.sizeToFit()
    }
}

// MARK: - Constants
private extension Constants {
    static let defaultLabelLinesAmount = 2
    static let defaultIconSize = CGFloat(75)
}
