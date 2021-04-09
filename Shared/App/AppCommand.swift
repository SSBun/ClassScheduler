//
//  AppCommand.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import Moya


protocol AppCommand {
    func execute(in store: Store)
}


struct RequestStudentInfoCommand: AppCommand {
    let id: String
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        API<Services.Student>.publisher(for: .info(id: id)).sink { finish in
            token.unseal()
            if case .failure(let error) = finish {
                LOG(level: .error, error)
            }
        } receiveValue: { response in
            LOG(category: .message, "request student info: \(response.data)")
        }
        .seal(in: token)
    }
}
