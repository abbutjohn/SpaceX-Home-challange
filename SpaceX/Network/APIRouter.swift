//
//  Router.swift
//  iOSTakeHomeChallenge
//
//  Created by Abbut john on 14/06/2021.
//

import Foundation
import Alamofire

enum APIRouter :URLRequestConvertible{
    
    case getAllRockets
    case getRocketInfo(id: String)
    
    
    private var path: String {
        switch self {
        case .getAllRockets:
            return "/rockets"
        case .getRocketInfo:
            return "/rockets"
        }
    }
    private var method: HTTPMethod {
        switch self {
        case .getAllRockets, .getRocketInfo:
            return .get
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .getAllRockets:
            return nil
        case .getRocketInfo(let id):
            return [K.APIParameterKey.id: id]
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        
        
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}

