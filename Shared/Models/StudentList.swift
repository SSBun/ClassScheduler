//
//  StudentListModel.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

struct StudentList {
    var students: [Int] = [1]
    var currentStudent: Student = .mock
    
    /// All student data, [ID: Student]
    var studentsData: [Int: Student] = [1: .init(id: 1, name: "ssbun")]
}
