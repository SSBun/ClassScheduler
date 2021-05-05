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
    var appointment: LessonAppointment? { store.appState.appointmentsData[block.id] }
    var student: Student? { store.appState.studentList.studentsData[appointment?.studentId ?? ""] }
    
    var body: some View {
        if appointment?.state == .normal && !store.appState.lessonList.appointmentDetail.isRequesting {
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
        .background(appointment?.state == .normal ? Color("appointment_bg") : Color("appointment_bg_locked"))
        .border(Color.white.opacity(0.6), width: block.id == store.appState.lessonList.appointmentDetail.appointment ? 3 : 0)
        .cornerRadius(5)
        .padding(.init(top: 1, leading: 5, bottom: 1, trailing: 5))
        .onTapGesture {
            store.dispatch(.selectAppointment(block.id))
        }
    }
}
