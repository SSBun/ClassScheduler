//
//  AppCommand.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import Combine
import Moya
import SwiftyJSON
import PromiseKit


protocol AppCommand {
    func execute(in store: Store)
}

struct RequestStudentInfoCommand: AppCommand {
    let id: String
    
    func execute(in store: Store) {
        firstly {
            API<Services>.promise(for: .info(id: id))
        }.done { response in
            do {
                let student = try Student.unpack(response.data)
                store.dispatch(.refreshStudentInfo(student))
            } catch(let error) {
                LOG(level: .error, error)
            }
        }.catch { error in
            LOG(level: .error, error)
        }
    }
}

struct RequestAppointmentCommand: AppCommand {
    let appointment: Int
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        Future<String, CSError> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                promise(Bool.random() ? .success("预约课程成功") : .failure("预约课程失败"))
            }
        }
        .eraseToAnyPublisher()
        .sink { completion in
            token.unseal()
            if case let .failure(error) = completion {
                store.dispatch(.requestAppointmentCompletion(.failure(error)))
            }
        } receiveValue: {
            store.dispatch(.requestAppointmentCompletion(.success($0)))
        }
        .seal(in: token)
    }
}

struct CancelAppointmentCommand: AppCommand {
    let appointment: Int
    func execute(in store: Store) {
        let token = SubscriptionToken()
        
        Future<String, CSError> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                promise(Bool.random() ? .success("取消预约成功") : .failure("取消预约失败"))
            }
        }
        .eraseToAnyPublisher()
        .sink { completion in
            token.unseal()
            if case let .failure(error) = completion {
                store.dispatch(.cancelAppointmentCompletion(.failure(error)))
            }
        } receiveValue: {
            store.dispatch(.cancelAppointmentCompletion(.success($0)))
        }
        .seal(in: token)
    }
}

struct RequestAppointmentInfoCommand: AppCommand {
    let student: String
    
    func execute(in store: Store) {
        var info: LessonAppointment.LessonInfo = .init()
        info.studentId = student
        firstly {
            API<Services>.promise(for: .getSubjects(studentId: student))
        }.then { response -> Promise<Response> in
            let json = JSON(response.data)
            let subject = json["subjects"][0]
            info.subjectId = subject["id"].intValue
            info.subjectName = subject["name"].stringValue
            return API<Services>.promise(for: .getCurrentTrack(studentId: student, subjectId: subject["id"].intValue))
        }.then { response -> Promise<Response> in
            let json = JSON(response.data)
            let subject = json["subjects"][0]
            info.subjectId = subject["id"].intValue
            info.subjectName = subject["name"].stringValue
            return API<Services>.promise(for: .getCurrentTrack(studentId: student, subjectId: subject["id"].intValue))
        }.catch { _ in
            
        }
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
