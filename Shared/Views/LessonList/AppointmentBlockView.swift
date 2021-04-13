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
        if block.appointment.state == .normal && !store.appState.lessonList.appointmentDetail.isRequesting {
            content
                .onDrag({ DragDropData(block).itemProvider })
        } else {
            content
        }
    }
    
    @ViewBuilder
    var content: some View {
        VStack {
            Text("\(student?.fullName ?? "\(block.id)")")
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .background(block.appointment.state == .normal ? Color("appointment_bg") : Color("appointment_bg_locked"))
        .cornerRadius(5)
        .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
        .onTapGesture {
            store.dispatch(.selectAppointment(block.appointment))
        }
    }
}
