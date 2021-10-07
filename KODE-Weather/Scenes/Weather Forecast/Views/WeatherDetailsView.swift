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
    
    // MARK: - Init
    init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        circleView = UIView()
        bigImageView = UIImageView()
        stackView = UIStackView()
        stackViewSubviews = []
        
        equasionHelper = EquasionHelper()

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
            let finalMaxWidth = max(maxWidthTop, maxWidthBottom, maxWidthMiddle)

            view.snp.makeConstraints { make in
                make.width.lessThanOrEqualTo(finalMaxWidth)
            }
        }
        
    }
    
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
            make.bottom.equalToSuperview().inset(Constants.StackView.horizontalInset)
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
                self.fillStackView()
                self.stackView.snp.updateConstraints { make in
                    make.leading.equalToSuperview().inset(Constants.StackView.horizontalInset)
                }
                self.activityIndicator.stopAnimating()
                self.layoutIfNeeded()
            }
            
        })
    }
    
}

private extension Constants {
    struct StackView {
        static let horizontalInset = CGFloat(15)
        static let verticalInset = CGFloat(10)
    }
}
