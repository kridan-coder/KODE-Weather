//
//  APIClient.swift
//  KODE-Weather
//
//  Created by Developer on 23.09.2021.
//

import Foundation
import Alamofire
import SystemConfiguration

struct APIRoutable: URLRequestConvertible {
    var baseURL: String = Constants.API.baseURL
    var path: String
    var method: HTTPMethod
    var parameters: Parameters?
    var encoding: ParameterEncoding
    
    func asURLRequest() throws -> URLRequest {
        let spacelessString = (baseURL + path).replacingOccurrences(of: " ", with: "%20")
        let url = try spacelessString.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

final class APIClient {
    private let networkReachabilityManager = NetworkReachabilityManager()
    
    private func isConnectedToNetwork() -> Bool {
        return networkReachabilityManager?.isReachable ?? false
    }
    
    private func handleStatusCode(response: HTTPURLResponse?) -> CustomError? {
        switch response?.statusCode {
        case 401:
            return APIError.badAPIKey
        case 404:
            return APIError.notFound
        case 429:
            return APIError.tooManyRequests
        default:
            return nil
        }
    }
    
    // GENERIC method
    private func perform<T: Decodable>(_ apiRoute: APIRoutable, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard isConnectedToNetwork() else {
            completion(.failure(APIError.noInternet))
            return
        }
        
        let dataRequest = AF.request(apiRoute)
        dataRequest
            .validate(statusCode: 200..<300)
            .responseDecodable {  (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    if let customError = self.handleStatusCode(response: response.response) {
                        completion(.failure(customError))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }
    
    func getWeatherInfoViaCityName(_ cityName: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let weatherInfoRoute = APIRoutable(path: "data/2.5/weather?q=\(cityName)&units=metric&appid=\(APIKey.key)",
                                           method: .get,
                                           encoding: URLEncoding.default)
        perform(weatherInfoRoute, completion: completion)
    }
    
    func generateIconLink(iconID: String) -> String {
        return Constants.API.iconURL + "\(iconID)@2x.png"
    }
    
}
