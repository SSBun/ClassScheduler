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
                HStack(spacing: 10) {
                    Image(systemName: "arrow.clockwise.circle")
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.red))
                        .onTapGesture {
                            store.dispatch(.deactivateAllCourse)
                        }
                    Image(systemName: "plus")
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.blue))
                        .onTapGesture {
                            store.dispatch(.updateCourse(nil))
                        }
                }
                .padding(.horizontal, 4)
                .padding(.top, 8)
            }
        }
        .background(Color("student_list_bg"))
        .frame(minWidth: 150, maxWidth: 150, maxHeight: .infinity)
    }
}

extension CourseListView {
    struct Cell: View {
        @EnvironmentObject var store: Store
        @State private var isPresented: Bool = false
        
        let course: Course
        
        var body: some View {
            HStack {
                Rectangle()
                    .fill(store.appState.courseEvaluation.selectedCourses.contains(course.id) ? Color.red : Color.gray)
                    .frame(minWidth: 20, maxWidth: 20, maxHeight: .infinity)
                    .onTapGesture {
                        store.dispatch(.activateCourse(course.id, nil))
                    }
                ZStack {
                    Text(course.title)
                    RightClickableView(content: {}) {
                        isPresented = true
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
            .background(store.appState.courseEvaluation.currentCourse == course.id ? Color("student_block_bg_noinfo") : Color.gray.opacity(0.7))
            .cornerRadius(8)
            .onTapGesture {
                store.dispatch(.selectCourse(course.id))
            }
            .alert(isPresented: $isPresented) {
                Alert(title: Text("要删除吗"), message: nil, primaryButton: .default(Text("确定"), action: {
                    store.dispatch(.removeCourse(course.id))
                }), secondaryButton: .cancel(Text("取消")))
            }
        }
    }
}
