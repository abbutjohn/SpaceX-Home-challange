//
//  Router.swift
//  iOSTakeHomeChallenge
//
//  Created by Abbut john on 14/06/2021.
//

import UIKit
import Alamofire

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        
        return AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                            completion(response.result)
        }
    }
    

    static func getRockets(completion:@escaping (Result<[Rocket], AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        performRequest(route: APIRouter.getAllRockets, decoder: jsonDecoder, completion: completion)
    }
    
    static func getRocketInfo(id: String, completion:@escaping (Result<Rocket, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        performRequest(route: APIRouter.getRocketInfo(id: id), decoder: jsonDecoder, completion: completion)
    }
}

