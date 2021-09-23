//
//  Dependencies.swift
//  KODE-Weather
//
//  Created by Developer on 23.09.2021.
//

import Foundation

struct AppDependencies: HasAPIClientProvider {
    let apiClient: APIClient
}

protocol HasAPIClientProvider {
    var apiClient: APIClient { get }
}
