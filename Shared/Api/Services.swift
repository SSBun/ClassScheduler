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
        case loin(account: String, password: String)
    }
    
    enum Student {
        case info(id: String)
    }
}

extension Services.Student: TargetType {
    var baseURL: URL {
        URL(string: "https://cloud-gateway.codemao.cn")!
    }
    
    var path: String {
        switch self {
        case .info(id: let id):
            return "/api-crm-web/admin/users/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .info(id: _):
            return .get
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
        case .info(id: _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "authorization_type": "3",
                "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36",
                "Cookie": Teacher.shared.token,
                "Host": "cloud-gateway.codemao.cn",
                "Origin": "https://crm.codemao.cn",
                "Referer": "https://crm.codemao.cn"]
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
