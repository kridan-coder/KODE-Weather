//
//  WeatherDetailsViewController.swift
//  KODE-Weather
//
//  Created by Developer on 28.09.2021.
//

import UIKit

final class WeatherDetailsViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: WeatherDetailsViewModel
    
    // MARK: - Init
    init(viewModel: WeatherDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
