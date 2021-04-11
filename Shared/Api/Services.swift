//
//  Services.swift
//  ClassScheduler (iOS)
//
//  Created by caishilin on 2021/4/6.
//

import Foundation
import Moya

enum Services {
    enum Authorization {
        case loing(account: String, password: String)
    }
    
    enum Student {
        case info(id: Int)
    }
}

extension Services.Student: TargetType {
    var baseURL: URL {
        URL(string: "http://httpbin.org")!
    }
    
    var path: String {
        switch self {
        case .info(id: _):
            return "post"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .info(id: _):
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .info(id: let id):
            return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .info(id: let id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
