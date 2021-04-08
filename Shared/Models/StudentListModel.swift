//
//  StudentListModel.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

struct StudentList {
    var students: [Student] = (0...30).map { .init(name: "student: \($0)") }
    var currentStudent: Student = .mock
}
