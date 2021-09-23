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
    var baseURL: String = ""
    var path: String
    var method: HTTPMethod
    var parameters: Parameters?
    var encoding: ParameterEncoding
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
