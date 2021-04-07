//
//  WeekSwitcher.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/7.
//

import SwiftUI

struct WeekSwitcher: View {
    @EnvironmentObject var store: Store
    
    var day: CourseCalendar.Day { store.appState.lessonList.week.days[0] }
    
    var body: some View {
        HStack {
            Button {
                store.dispatch(.switchWeek(store.appState.lessonList.weekOffset-1))
            } label: {
                Image(systemName: "arrowtriangle.left.fill")
            }
            Text("\(day.date.toString(.custom("YYYY年 MM月")))")
            Button {
                store.dispatch(.switchWeek(store.appState.lessonList.weekOffset+1))
            } label: {
                Image(systemName: "arrowtriangle.right.fill")
            }
        }
    }
}
