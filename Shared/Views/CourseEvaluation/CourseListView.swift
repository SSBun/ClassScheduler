//
//  CourseListView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/15.
//

import SwiftUI

struct CourseListView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ForEach(store.appState.courseEvaluation.searchedCourses, id: \.self) { courseId in
                    if let course = store.appState.courseEvaluation.coursesData[courseId] {
                        Cell(course: course)
                            .padding(.horizontal, 4)
                            .padding(.top, 8)
                    }
                }
            }
        }
        .background(Color("student_list_bg"))
        .frame(minWidth: 150, maxWidth: 150, maxHeight: .infinity)
    }
}

extension CourseListView {
    struct Cell: View {
        @EnvironmentObject var store: Store
        
        let course: Course
        
        var body: some View {
            HStack {
                Text(course.title)
            }
            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
            .background(store.appState.courseEvaluation.currentCourse == course.id ? Color("student_block_bg_noinfo") : Color.gray.opacity(0.7))
            .cornerRadius(8)
        }
    }
}
