//
//  AppCommand.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import Moya
import SwiftyJSON


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
            do {
                let student = try Student.unpack(response.data)
                DispatchQueue.main.async {
                    store.dispatch(.refreshStudentInfo(student))
                }
            } catch(let error) {
                LOG(level: .error, error)
            }
        }
        .seal(in: token)
    }
}

struct InitializeAppCommand: AppCommand {
    let state: AppState
    func execute(in store: Store) {
        do {
            var newState = state
            let students = try Student.db.get()
            var studentMap: [String: Student] = [:]
            students.forEach { student in
                studentMap[student.id] = student
            }
            newState.studentList.studentsData = studentMap
            newState.studentList.searchedStudents = studentMap.keys.sorted()
            store.dispatch(.loadApp(newState))
            store.dispatch(.switchWeek(0))
        } catch(let error) {
            LOG(category: .command, error)
        }
    }
}
