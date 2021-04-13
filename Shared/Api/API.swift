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
    static func promise(for service: Services) -> Promise<Moya.Response> {
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
}

