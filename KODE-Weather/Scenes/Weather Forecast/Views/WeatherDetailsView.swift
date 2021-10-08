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
    
    // MARK: - Init
    init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        circleView = UIView()
        bigImageView = UIImageView()
        stackView = UIStackView()
        stackViewSubviews = []
        
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func setup() {
        createConstraints()
        self.layoutIfNeeded()
        initializeUI()
    }
    
    func setupBigImageView(with image: UIImage?) {
        bigImageView.image = image
    }
    
    func setupStackViewSubviews(with stackViewSubviews: [UIView]) {
        self.stackViewSubviews = stackViewSubviews
    }
    
    func finishedLoadingData() {
        animateViews()
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
        
        createCircleViewConstraints()
        createBigImageViewConstraints()
        createStackViewConstraints()
        createActivityIndicatorConstraints()
    }
    
    private func fillStackView() {
        for view in stackViewSubviews {
            stackView.addArrangedSubview(view)
        }
        self.layoutIfNeeded()
        for view in stackViewSubviews {
            let finalMaxWidth = calculateMaxWidthOfView(view)
            view.snp.makeConstraints { make in
                make.width.lessThanOrEqualTo(finalMaxWidth)
            }
        }
    }
    
    private func animateViews() {
        UIView.animate(withDuration: Constants.Animation.fastAnimationDuration, animations: {
            self.animateCirleView()
        }, completion: { _ in
            self.animateStackView()
        })
    }
    
    private func calculateMaxWidthOfView(_ view: UIView) -> Double {
        let maxWidthTop = EquasionHelper
            .distanceToEdgeOfCircle(axisY: view.frame.minY,
                                    circle: Circumference(radius: circleView.frame.width / 2,
                                                          center: circleView.center))
        let maxWidthMiddle = EquasionHelper
            .distanceToEdgeOfCircle(axisY: view.frame.midY,
                                    circle: Circumference(radius: circleView.frame.width / 2,
                                                          center: circleView.center))
        let maxWidthBottom = EquasionHelper
            .distanceToEdgeOfCircle(axisY: view.frame.maxY,
                                    circle: Circumference(radius: circleView.frame.width / 2,
                                                          center: circleView.center))
        let finalMaxWidth = max(maxWidthTop, maxWidthBottom, maxWidthMiddle)
        return min(Double(self.frame.width), finalMaxWidth)
    }
    
    private func animateCirleView() {
        self.circleView.snp.updateConstraints { make in
            make.left.equalToSuperview().inset(self.frame.width * Constants.CircleView.widthInsetMultiplier)
            make.top.equalToSuperview()
        }
        self.layoutIfNeeded()
    }
    
    private func animateStackView() {
        UIView.animate(withDuration: Constants.Animation.defaultAnimationDuration) {
            self.fillStackView()
            self.stackView.snp.updateConstraints { make in
                make.leading.equalToSuperview().inset(Constants.StackView.horizontalInset)
            }
            self.activityIndicator.stopAnimating()
            self.layoutIfNeeded()
        }
    }
    
    // UI
    private func setupCircleViewUI() {
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.clipsToBounds = true
    }
    
    private func setupBigImageViewUI() {
        bigImageView.contentMode = .scaleAspectFill
    }
    
    private func setupStackViewUI() {
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.StackView.verticalInset
    }
    
    private func setupActivityIndicatorUI() {
        activityIndicator.startAnimating()
    }
    
    // Constraints
    private func createActivityIndicatorConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createCircleViewConstraints() {
        circleView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(Constants.Animation.defaultOutterInset)
            make.size.equalTo(self.snp.height).multipliedBy(Constants.CircleView.sizeMultiplier)
        }
    }
    
    private func createBigImageViewConstraints() {
        bigImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(self).multipliedBy(Constants.BigImageView.widthMultiplier)
        }
    }
    
    private func createStackViewConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(-Constants.Animation.bigOutterInset)
            make.top.equalToSuperview().inset(Constants.StackView.verticalInset)
            make.bottom.equalToSuperview().inset(Constants.StackView.horizontalInset)
            make.width.equalToSuperview()
        }
    }
    
}

// MARK: - Constants
private extension Constants {
    struct Animation {
        static let defaultAnimationDuration = Double(0.45)
        static let fastAnimationDuration = Double(0.3)
        static let defaultOutterInset = CGFloat(500)
        static let bigOutterInset = CGFloat(1000)
    }
    
    struct CircleView {
        static let widthInsetMultiplier = CGFloat(0.36)
        static let sizeMultiplier = CGFloat(1.38)
    }
    
    struct BigImageView {
        static let widthMultiplier = CGFloat(0.64)
    }
    
    struct StackView {
        static let horizontalInset = CGFloat(15)
        static let verticalInset = CGFloat(10)
    }
    
}
