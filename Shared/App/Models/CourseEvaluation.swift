//
//  CourseEvaluation.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/15.
//

import Foundation

struct CourseEvaluation {
    var searchedCourses: [Int] = [1, 2]
    var currentCourse: Int?
    var coursesData: [Int: Course] = [1: .mock, 2: .mock]        
}
