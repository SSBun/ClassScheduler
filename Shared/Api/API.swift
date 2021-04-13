//
//  API.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/6.
//

import Foundation
import Combine
import Moya

struct API<Services: TargetType> {
    static func publisher(for service: Services) -> AnyPublisher<Moya.Response, MoyaError> {
        Future { promise in
            MoyaProvider<Services>().request(service) { result in
                promise(result)
            }
        }.eraseToAnyPublisher()
    }
}

