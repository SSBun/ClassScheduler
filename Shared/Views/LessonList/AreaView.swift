//
//  AreaView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct AreaView: View {
    @EnvironmentObject var store: Store
    var area: LessonList.ColumnArea
    @State var isEntered: Bool = false
    
    private var markTitle: String {
        var title = ""
        if case let .week(day) = area.columnType {
            title += day.date.weekdayName(.short)
            if case let .timeRange(timeRange) = area.type {
                title += "\n\n"
                title += "\(timeRange.range.0) - \(timeRange.range.1)"
            }
        }
        return title
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(isEntered ? Color.gray.opacity(0.1) : Color.gray.opacity(0))
            Text(markTitle)
                .font(.system(size: 24, weight: .black))
                .foregroundColor(Color.black.opacity(0.3))
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 1)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                ForEach(area.items, id: \.id) { block in
                    if block is AppointmentBlock {
                        AppointmentBlockView(block: block as! AppointmentBlock)
                    }
                }
            }
            .padding(.vertical, 5)
        }
        .background(Color("area_bg").opacity(0.5))
        .frame(minWidth: 150, minHeight: 180)
        .onDrop(DropGroupDelegator(isEnabled: area.items.count < 4,
                                   isEntered: $isEntered,
                                   dropCallbacks:
                                    (AppointmentBlock.self,
                                     DragDropData<AppointmentBlock>.self,
                                     { p in
                                        let block = (p as! DragDropData<AppointmentBlock>).data
                                        store.dispatch(.moveBlock(block.id, area.id))
                                     }),
                                   (Student.self,
                                    DragDropData<Student>.self,
                                    { p in
                                        let student = (p as! DragDropData<Student>).data
                                        store.dispatch(.insertAppointment(student: student.id, to: area.id))
                                    })
        ))
    }
}
