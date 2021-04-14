//
//  API.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/6.
//

import Foundation
import Combine
import Moya
import PromiseKit

struct API<Services: TargetType> {
    
    /// Reqeust API to get a response
    static func promise(for service: Services) -> Promise<Response> {
        Promise { seal in
            MoyaProvider<Services>().request(service) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    /// Request API to get a data if the status code of the response is OK.
    static func promise(for service: Services) -> Promise<Data> {
        Promise { seal in
            MoyaProvider<Services>().request(service) { result in
                switch result {
                case .success(let response):
                    if (200...300).contains(response.statusCode) {
                        seal.fulfill(response.data)

                    } else {
                        seal.reject(CSError(stringLiteral: "request \(service) failure, status code is: \(response.statusCode)"))
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    /// Request API to get a specified type result decoded from the data of the response.
    static func promise<DataType: Decodable>(for service: Services) -> Promise<DataType> {
        Promise { seal in
            MoyaProvider<Services>().request(service) { result in
                switch result {
                case .success(let response):
                    if (200...300).contains(response.statusCode) {
                        do {
                            let result = try DataType.unpack(response.data)
                            seal.fulfill(result)
                        } catch(let unpackingError) {
                            seal.reject(unpackingError)
                        }
                    } else {
                        seal.reject(CSError(stringLiteral: "request \(service) failure, status code is: \(response.statusCode)"))
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}

