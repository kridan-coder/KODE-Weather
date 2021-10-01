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
    private let circleView: UIView
    private let stackView: UIStackView
    
    private let equasionHelper: EquasionHelper
    
    private let button: UIButton
    
    private var testViews: [UIView]
    
    // MARK: - Init
    init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        circleView = UIView()
        bigImageView = UIImageView()
        stackView = UIStackView()
        
        equasionHelper = EquasionHelper()
        
        testViews = []

        
        button = UIButton(type: .system)
        button.setTitle("Hello!", for: .normal)
        
        super.init(frame: CGRect.zero)
        
        for iterator in 0..<50 {
            var view = UIView()
            view.frame = CGRect(x: 0, y: (iterator + 1)*30, width: 1000, height: 2)
            view.backgroundColor = .red
            testViews.append(view)
            self.addSubview(view)
        }
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
        animateViews()
    }
    
    // MARK: - Public Methods
    func setup() {
        createConstraints()
        self.layoutIfNeeded()
        initializeUI()
    }
    
    // MARK: - Private Methods
    private func initializeUI() {
        backgroundColor = .mainColor
        setupActivityIndicatorUI()
        setupStackViewUI()
        setupCircleViewUI()
        setupBigImageViewUI()
    }
    
    private func createConstraints() {
        addSubview(activityIndicator)
        addSubview(circleView)
        circleView.addSubview(bigImageView)
        addSubview(stackView)
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        createCircleViewConstraints()
        createBigImageViewConstraints()
        createStackViewConstraints()
        createActivityIndicatorConstraints()
    }
    
    private func setupCircleViewUI() {
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.clipsToBounds = true
    }
    
    private func setupBigImageViewUI() {
        bigImageView.contentMode = .scaleAspectFill
        bigImageView.image = UIImage(named: "ScatteredClouds")
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
    
    private func createCircleViewConstraints() {
        circleView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(500)
            make.size.equalTo(self.snp.height).multipliedBy(1.38)
        }
    }
    
    private func createBigImageViewConstraints() {
        bigImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(self).multipliedBy(0.64)
        }
    }
    
    private func createStackViewConstraints() {}
    
    private func animateViews() {
        UIView.animate(withDuration: 0.3, animations: {
                        self.circleView.snp.updateConstraints { make in
                            make.left.equalToSuperview().inset(self.frame.width * 0.36)
                            make.top.equalToSuperview()
                        }
                        self.layoutIfNeeded()
            
        }) { finished in

//            print(result[0].x, result[0].y)
            print(self.frame.width)
//            print(self.frame.height)
            
            for element in self.testViews {
                let result = self.equasionHelper.distanceToEdgeOfCircle(axisY: Double(element.frame.midY),
                                                  circle: Circumference(radius: Double(self.circleView.layer.cornerRadius),
                                                                                             center: CGPoint(x: self.circleView.frame.midX, y: self.circleView.frame.midY)))
                print(result)
            }
        }
    }
    
}
