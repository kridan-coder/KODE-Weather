//
//  WeatherDetailsView.swift
//  KODE-Weather
//
//  Created by Developer on 30.09.2021.
//

import UIKit

final class WeatherDetailsView: UIView {
    // MARK: - Properties
    private let activityIndicator: UIActivityIndicatorView
    
    private let bigImageView: UIImageView
    private let stackView: UIStackView
    
    private let button: UIButton
    
    // MARK: - Init
    init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        bigImageView = UIImageView()
        stackView = UIStackView()
        
        button = UIButton(type: .system)
        button.setTitle("Hello!", for: .normal)
        
        super.init(frame: CGRect.zero)
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        initializeUI()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
        animateViews()
    }
    
    // MARK: - Private Methods
    private func initializeUI() {
        backgroundColor = .mainColor
        setupActivityIndicatorUI()
        setupStackViewUI()
        setupBigImageViewUI()
    }
    
    private func createConstraints() {
        addSubview(activityIndicator)
        addSubview(bigImageView)
        addSubview(stackView)
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        createBigImageViewConstraints()
        createStackViewConstraints()
        createActivityIndicatorConstraints()
    }
    
    private func setupBigImageViewUI() {
        bigImageView.layer.cornerRadius = bigImageView.frame.height / 2
        bigImageView.image = UIImage(named: "Rain")
    }
    
    private func setupStackViewUI() {
        stackView.alignment = .leading
    }
    
    private func setupActivityIndicatorUI() {
        activityIndicator.startAnimating()
    }
    
    private func createActivityIndicatorConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createBigImageViewConstraints() {
        bigImageView.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(-500)
            make.width.equalToSuperview().multipliedBy(0.64)
            make.height.equalToSuperview()
        }
    }
    
    private func createStackViewConstraints() {}
    
    private func animateViews() {
        UIView.animate(withDuration: 0.3) {
            self.bigImageView.snp.updateConstraints { make in
                make.bottom.right.equalToSuperview()
            }
            self.layoutIfNeeded()
        }
    }
    
}
