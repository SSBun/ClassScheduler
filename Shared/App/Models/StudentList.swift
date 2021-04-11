//
//  StudentListModel.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import Combine

struct StudentList {
    /// LIst data
    var searchedStudents: [String] = []
    /// Current selected student's ID
    var currentStudent: String?
    /// All student data, [ID: Student]
    var studentsData: [String: Student] = [:]
    /// Search bar content
    var search: Search = .init()
    
    class Search: ObservableObject {
        /// The searched content
        @Published var content: String = ""
        
        var result: AnyPublisher<String, Never> {
            $content.throttle(for: .milliseconds(300), scheduler: RunLoop.main, latest: true).eraseToAnyPublisher()
        }
    }
}
