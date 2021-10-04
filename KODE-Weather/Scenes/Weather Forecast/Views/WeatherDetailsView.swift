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
    
    private var stackViewSubviews: [UIView]
    
    private let equasionHelper: EquasionHelper
    
    private let button: UIButton
    
    // MARK: - Init
    init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        circleView = UIView()
        bigImageView = UIImageView()
        stackView = UIStackView()
        
        stackViewSubviews = [DegreesView(), IconView(), KeyValueView(), KeyValueView(), KeyValueView()]
        
        equasionHelper = EquasionHelper()
        
        button = UIButton(type: .system)
        button.setTitle("Hello!", for: .normal)

        super.init(frame: CGRect.zero)
        
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
    
    private func fillStackView(with subviews: [UIView]) {
        for view in subviews {
            stackView.addArrangedSubview(view)
        }
        self.layoutIfNeeded()
        for view in subviews {
            stackView.addArrangedSubview(view)
            let maxWidthTop = equasionHelper.distanceToEdgeOfCircle(axisY: view.frame.minY + Constants.StackView.verticalInset,
                                                                    circle: Circumference(radius: circleView.frame.width / 2,
                                                                                          center: circleView.center)) - Double(Constants.StackView.horizontalInset)*2
            
            let maxWidthMiddle = equasionHelper.distanceToEdgeOfCircle(axisY: view.frame.midY + Constants.StackView.verticalInset,
                                                                       circle: Circumference(radius: circleView.frame.width / 2,
                                                                                             center: circleView.center)) - Double(Constants.StackView.horizontalInset)*2
            
            let maxWidthBottom = equasionHelper.distanceToEdgeOfCircle(axisY: view.frame.maxY + Constants.StackView.verticalInset,
                                                                       circle: Circumference(radius: circleView.frame.width / 2,
                                                                                             center: circleView.center)) - Double(Constants.StackView.horizontalInset)*2
            let finalMaxWidth = min(maxWidthTop, maxWidthBottom, maxWidthMiddle, Double(frame.width - Constants.StackView.horizontalInset*2))
            
            print(maxWidthTop)
            
            print(maxWidthBottom)
            
            print(frame.width)
            print(frame.height)
            
            print(view.frame.width)
            
            print(view.frame.height)
            
            print(view.frame.minY)
            
            print(view.frame.maxY)

            
            view.snp.makeConstraints { make in
                make.width.lessThanOrEqualTo(finalMaxWidth)
            }
            //view.sizeToFit()
        }
        
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
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.StackView.verticalInset
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
    
    private func createStackViewConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(-1000)
            make.top.equalToSuperview().inset(Constants.StackView.verticalInset)
            make.bottom.lessThanOrEqualToSuperview().inset(Constants.StackView.horizontalInset)
            make.width.equalToSuperview()
        }
    }
    
    private func animateViews() {
        UIView.animate(withDuration: 0.3, animations: {
                        self.circleView.snp.updateConstraints { make in
                            make.left.equalToSuperview().inset(self.frame.width * 0.36)
                            make.top.equalToSuperview()
                        }
                        self.layoutIfNeeded()
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.45) {
                self.fillStackView(with: self.stackViewSubviews)
                self.stackView.snp.updateConstraints { make in
                    make.leading.equalToSuperview().inset(Constants.StackView.horizontalInset)
                }
                self.layoutIfNeeded()
            }
            
        })
    }
    
}

private extension Constants {
    struct StackView {
        static let horizontalInset = CGFloat(15)
        static let verticalInset = CGFloat(20)
    }
}
