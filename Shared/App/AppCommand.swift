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

struct InitializeAppCommand: AppCommand {
    let state: AppState
    func execute(in store: Store) {
        do {
            var newState = state
            let students = try Student.db.get(on: [])
            let ids = students.map { $0.id }
            var studentMap: [Int: Student] = [:]
            students.forEach { student in
                studentMap[student.id] = student
            }
            newState.studentList.students = ids
            newState.studentList.studentsData = studentMap
            store.dispatch(.loadApp(newState))
        } catch(let error) {
            LOG(category: .command, error)
        }
    }
}
