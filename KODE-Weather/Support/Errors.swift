//
//  Errors.swift
//  KODE-Weather
//
//  Created by Developer on 28.09.2021.
//

import Foundation

protocol CustomError: Error {
    var errorTitle: String { get }
}

enum MapError: CustomError {
    case noSuchPlace
}

enum APIError: CustomError {
    case noInternet
    case basic
}

extension MapError {
    var errorTitle: String {
        switch self {
        case .noSuchPlace:
            return R.string.localizable.noSuchPlaceErrorTitle()
        default:
            return R.string.localizable.defaultErrorTitle()
        }
    }
}

extension MapError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noSuchPlace:
            return R.string.localizable.noSuchPlaceErrorDescription()
        default:
            return R.string.localizable.defaultErrorDescription()
        }
    }
}

extension APIError {
    var errorTitle: String {
        switch self {
        case .noInternet:
            return R.string.localizable.noInternetErrorTitle()
        default:
            return R.string.localizable.defaultErrorTitle()
        }
    }
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return R.string.localizable.noInternetErrorDescription()
        default:
            return R.string.localizable.defaultErrorDescription()
        }
    }
}
