//
//  PickPlaceView.swift
//  KODE-Weather
//
//  Created by Developer on 24.09.2021.
//

import UIKit
import SnapKit

final class PickPlaceView: UIView {
    
    // MARK: - Types
    // MARK: - Properties
    
    private var viewModel: PickPlaceViewModel?
    
    var showWeatherButton: UIButton
    var cancelButton: UIButton
    var placeNameLabel: UILabel
    var placeCoordinatesLabel: UILabel
    
    // MARK: - Init
    init() {
        showWeatherButton = UIButton(type: .system)
        cancelButton = UIButton(type: .system)
        placeNameLabel = UILabel()
        placeCoordinatesLabel = UILabel()
        super.init(frame: CGRect.zero)
        initializeUI()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Public Methods
    func configure(with viewModel: PickPlaceViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Actions (@ojbc + @IBActions)
    // MARK: - Private Methods
    
    private func initializeUI() {
        backgroundColor = .white
        self.layer.cornerRadius = Constants.PickCityView.cornerRadius
        self.addShadow(opacity: Constants.PickCityView.shadowOpacity,
                       offset: Constants.PickCityView.shadowOffset,
                       radius: Constants.PickCityView.shadowRadius)
        setupShowWeatherButtonUI()
        setupCancelButtonUI()
        setupPlaceNameLabelUI()
        setupPlaceCoordinatesLabelUI()
    }
    
    private func createConstraints() {
        addSubview(showWeatherButton)
        addSubview(cancelButton)
        addSubview(placeNameLabel)
        addSubview(placeCoordinatesLabel)
        
        createShowWeatherButtonConstraints()
        createPlaceNameLabelConstraints()
        createCancelButtonConstraints()
        createPlaceCoordinatesLabelConstraints()
    }
    
    private func setupShowWeatherButtonUI() {
        showWeatherButton.backgroundColor = .none
        showWeatherButton.titleLabel?.font = UIFont.classic
        showWeatherButton.setTitleColor(.blue, for: .normal)
        showWeatherButton.layer.cornerRadius = Constants.ShowWeatherButton.cornerRadius
        showWeatherButton.layer.borderWidth = Constants.ShowWeatherButton.borderWidth
        showWeatherButton.layer.borderColor = UIColor.blue.cgColor
    }
    
    private func setupCancelButtonUI() {
        cancelButton.setImage(.cancel, for: .normal)
    }
    
    private func setupPlaceNameLabelUI() {
//        placeNameLabel.adjustsFontSizeToFitWidth = true
//        placeNameLabel.minimumScaleFactor = 0.5
        placeNameLabel.font = UIFont.big
        placeNameLabel.numberOfLines = Constants.PlaceNameLabel.linesAmount
    }
    
    private func setupPlaceCoordinatesLabelUI() {
//        placeCoordinatesLabel.adjustsFontSizeToFitWidth = true
//        placeCoordinatesLabel.minimumScaleFactor = 0.5
        placeCoordinatesLabel.font = UIFont.small
        placeCoordinatesLabel.numberOfLines = Constants.PlaceCoordinatesLabel.linesAmount
        placeCoordinatesLabel.textColor = .lightGray
    }
    
    private func createShowWeatherButtonConstraints() {
        showWeatherButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.defaultInset)
            make.bottom.equalToSuperview().inset(Constants.smallInset)
            make.height.equalTo(Constants.ShowWeatherButton.height)
        }
    }
    
    private func createPlaceNameLabelConstraints() {
        placeNameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(Constants.defaultInset)
            make.trailing.lessThanOrEqualTo(cancelButton.snp.leading).inset(-Constants.defaultInset)
        }
    }
    
    private func createCancelButtonConstraints() {
        cancelButton.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(Constants.defaultInset)
            make.bottom.lessThanOrEqualTo(showWeatherButton.snp.top)
        }
    }
    
    private func createPlaceCoordinatesLabelConstraints() {
        placeCoordinatesLabel.snp.makeConstraints { make in
            make.leading.equalTo(placeNameLabel)
            make.top.equalTo(placeNameLabel.snp.bottom).inset(-5)
            make.bottom.lessThanOrEqualTo(showWeatherButton.snp.top).inset(-Constants.defaultInset)
            make.trailing.lessThanOrEqualTo(cancelButton.snp.leading).inset(-Constants.defaultInset)
        }
    }
    
}

private extension Constants {
    struct PlaceNameLabel {
        static let linesAmount = 2
    }
    
    struct PlaceCoordinatesLabel {
        static let linesAmount = 1
    }
    
    struct PickCityView {
        static let cornerRadius = CGFloat(12)
        static let shadowOpacity = Float(0.9)
        static let shadowOffset = CGFloat(0)
        static let shadowRadius = CGFloat(8)
    }
    
    struct ShowWeatherButton {
        static let cornerRadius = CGFloat(22)
        static let borderWidth = CGFloat(1)
        static let height = CGFloat(50)
    }
    
    static let defaultInset = CGFloat(20)
    static let smallInset = CGFloat(15)
}
