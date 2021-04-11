//
//  AppointmentBlockView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct AppointmentBlockView: View {
    @EnvironmentObject var store: Store
    let block: AppointmentBlock
    var student: Student? { store.appState.studentList.studentsData[block.appointment.studentId] }
    
    var body: some View {
        content
        .onDrag({ DragDropData(block).itemProvider })
    }
    
    @ViewBuilder
    var content: some View {
        VStack {
            Text("\(student?.fullName ?? "\(block.id)")")
//            Text("\(block.appointment.day.date.toFormat("YYYY-MM-dd")) - \(block.appointment.timeRange.range.0)-\(block.appointment.timeRange.range.1)")
//                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .background(Color("appointment_bg"))
        .cornerRadius(5)
        .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
    }
}
