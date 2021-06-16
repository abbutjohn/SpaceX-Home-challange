//
//  Router.swift
//  iOSTakeHomeChallenge
//
//  Created by Abbut john on 14/06/2021.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://api.spacexdata.com/v4/"
    }
    
    struct APIParameterKey {
        static let id = "id"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
