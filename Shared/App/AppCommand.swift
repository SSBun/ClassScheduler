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
            
            let courses = try Course.db.get()
            var coursesData: [Int: Course] = [:]
            courses.forEach { course in
                coursesData[course.id] = course
            }
            newState.courseEvaluation.coursesData = coursesData
            newState.courseEvaluation.currentCourse = coursesData.keys.sorted().first ?? 0
            
            let performances = try CoursePerformance.db.get()
            var performancesData: [Int: CoursePerformance] = [:]
            performances.forEach { performance in
                performancesData[performance.id] = performance
            }
            newState.courseEvaluation.coursePerformances = performancesData
            newState.courseEvaluation.selectedPerformance = performancesData.keys.sorted().first ?? 0
            
            let messages = try TeacherMessage.db.get()
            var messagesData: [Int: TeacherMessage] = [:]
            messages.forEach { message in
                messagesData[message.id] = message
            }
            newState.courseEvaluation.teacherMessages = messagesData
            newState.courseEvaluation.selectedMessage = messagesData.keys.sorted().first ?? 0
            
            
            store.dispatch(.loadApp(newState))
            store.dispatch(.switchWeek(0))
        } catch(let error) {
            LOG(category: .command, error)
        }
    }
}

struct RequestStudentInfoCommand: AppCommand {
    let id: String
    
    func execute(in store: Store) {
        firstly {
            API<Services>.promise(for: .info(id: id))
        }.done { student in
            store.dispatch(.refreshStudentInfo(student))
        }.catch { error in
            LOG(level: .error, error)
        }
    }
}

struct RequestAppointmentCommand: AppCommand {
    let appointmentId: Int
    
    func execute(in store: Store) {
        guard var appointment = store.appState.appointmentsData[appointmentId],
              var info = appointment.info else {
            store.dispatch(.requestAppointmentCompletion(.failure("????????????")))
            return
        }
        info.time = Int(appointment.openningTime.timeIntervalSince1970)
        info.teacher = Teacher.mock
        appointment.info = info
        firstly {
            API<Services>.promise(for: .appointment(studentId: info.studentId,
                                                    teacherId: info.teacher!.id,
                                                    subjectId: info.subject.id,
                                                    trackId: info.track.id,
                                                    pointId: info.point.id,
                                                    time: info.time!)) as Promise<Data>
        }.done { _ in
            store.appState.appointmentsData[appointmentId] = appointment
            store.dispatch(.requestAppointmentCompletion(.success("????????????")))
        }.catch { error in
            store.dispatch(.requestAppointmentCompletion(.failure("????????????: \(error)")))
        }
    }
}

struct CancelAppointmentCommand: AppCommand {
    let appointment: Int
    func execute(in store: Store) {
        let token = SubscriptionToken()
        
        Future<String, CSError> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                promise(.success("????????????????????????, ???????????????,????????????????????????,??????????????????CRM???????????????"))
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
        var subject: CourseSubject?
        var track: CourseTrack?        
        firstly {
            API<Services>.promise(for: .getSubjects(studentId: student)) as Promise<SubjectsResult>
        }.compactMap {
            $0.subjects.first
        }.get {
            subject = $0
        }.then {
            API<Services>.promise(for: .getCurrentTrack(studentId: student, subjectId: $0.id)) as Promise<CurrentTrackResult>
        }.compactMap {
            $0.tracks.first
        }.get {
            track = $0
        }.then {
            API<Services>.promise(for: .getCurrentPoint(studentId: student, trackId: $0.id)) as Promise<CurrentPointResult>
        }.compactMap {
            $0.points.first
        }.done { point in
            if let subject = subject, let track = track {
                let info = LessonAppointment.Info(studentId: student, subject: subject, track: track, point: point)
                store.dispatch(.requestAppointmentInfoCompletion(.success(info)))
            } else {
                store.dispatch(.requestAppointmentInfoCompletion(.failure(.init(stringLiteral: "????????????????????????"))))
            }
        }.catch { error in
            store.dispatch(.requestAppointmentInfoCompletion(.failure(.init(stringLiteral: "????????????????????????"))))
        }
    }
}

