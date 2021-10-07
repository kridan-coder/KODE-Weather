//
//  KeyValueView.swift
//  KODE-Weather
//
//  Created by Developer on 04.10.2021.
//

import UIKit

final class KeyValueView: UIView {
    // MARK: - Properties
    private var viewModel: KeyValueViewModel?
    
    private let keyLabel: UILabel
    private let valueLabel: UILabel
    
    // MARK: - Init
    init() {
        keyLabel = UILabel()
        valueLabel = UILabel()
        
        super.init(frame: CGRect.zero)
        
        initializeUI()
        createConstraints()
        
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
    
    // MARK: - Public Methods
    func configure(with viewModel: KeyValueViewModel) {
        self.viewModel = viewModel
        keyLabel.text = viewModel.key
        valueLabel.text = viewModel.value
        
        viewModel.didUpdateData = {
            self.keyLabel.text = viewModel.key
            self.valueLabel.text = viewModel.value
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
