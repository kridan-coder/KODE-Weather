//
//  DegreesView.swift
//  KODE-Weather
//
//  Created by Developer on 01.10.2021.
//

import UIKit

final class ValueView: UIView {
    // MARK: - Properties
    private var viewModel: ValueViewModel?
    
    private let degreesLabelText: UILabel
    private let degreesLabelScale: UILabel
    
    // MARK: - Init
    init() {
        degreesLabelText = UILabel()
        degreesLabelScale = UILabel()
        degreesLabelScale.text = R.string.localizable.degrees()
        
        super.init(frame: CGRect.zero)
        
        initializeUI()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: ValueViewModel) {
        self.viewModel = viewModel
        degreesLabelText.text = viewModel.value
        
        viewModel.didUpdateData = {
            self.degreesLabelText.text = viewModel.value
        }
    }
    
    // MARK: - Private Methods
    private func initializeUI() {
        degreesLabelText.font = .singleValueFont
        degreesLabelText.numberOfLines = Constants.defaultLinesAmount
        degreesLabelText.textColor = .nearBlackColor
        degreesLabelScale.font = .degreesScaleFont
        degreesLabelScale.textColor = .nearBlackColor
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

// MARK: - Constants
private extension Constants {
    static let defaultLinesAmount = 1
}
