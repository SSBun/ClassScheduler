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
    private var title: String {
        let weekOffset = store.appState.lessonList.weekOffset
        switch weekOffset {
        case 0:
            return "本周"
        case -1:
            return "上周"
        case 1:
            return "下周"
        default:
            return "\(day.date.toString(.custom("YYYY年 MM月")))"
        }
    }
    
    var body: some View {
        HStack {
            Button {
                store.dispatch(.switchWeek(store.appState.lessonList.weekOffset-1))
            } label: {
                Image(systemName: "arrowtriangle.left.fill")
            }
        
            Text(title)
                .font(.system(size: 25, weight: .black, design: .rounded))
                .frame(width: 200, height: 30, alignment: .center)
            Button {
                store.dispatch(.switchWeek(store.appState.lessonList.weekOffset+1))
            } label: {
                Image(systemName: "arrowtriangle.right.fill")
            }
        }
    }
}
