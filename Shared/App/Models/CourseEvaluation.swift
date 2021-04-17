//
//  CourseEvaluation.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/15.
//

import Foundation
import Combine

struct CourseEvaluation {
    var searchedCourses: [Int] { coursesData.keys.sorted() }
    var currentCourse: Int = 0
    var coursesData: [Int: Course] = [:]
    var selectedCourses: [Int] = []
    
    var coursePerformances: [Int: CoursePerformance] = [:]
    var selectedPerformance: Int = 0
    var teacherMessages: [Int: TeacherMessage] = [:]
    var selectedMessage: Int = 0
    
    var result: String = ""
    
    var infoObserver: InfoObserver = .init()
}

extension CourseEvaluation {
    class InfoObserver: ObservableObject {
        @Published var courseTitle: String = ""
        @Published var courseContent: String = ""
        
        @Published var coursePerformance: String = ""
        @Published var teacherMessage: String = ""
        
        var courseInfoChanged: AnyPublisher<Void, Never> {
            $courseTitle.combineLatest($courseContent).map { _ in  }.throttle(for: .milliseconds(200), scheduler: RunLoop.main, latest: true).eraseToAnyPublisher()
        }
        
        var coursePerformanceInfoChanged: AnyPublisher<Void, Never> {
            $coursePerformance.map({ _ in }).throttle(for: .milliseconds(200), scheduler: RunLoop.main, latest: true).eraseToAnyPublisher()
        }
        
        var teacherMessageInfoChanged: AnyPublisher<Void, Never> {
            $teacherMessage.map({ _ in }).throttle(for: .milliseconds(200), scheduler: RunLoop.main, latest: true).eraseToAnyPublisher()
        }
    }
}
