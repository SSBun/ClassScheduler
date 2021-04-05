//
//  AppointmentBlock.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import SwiftUI

struct AppointmentBlock: Block {
    let id: String
    let appointment: LessonAppointment
}

struct AppointmentBlockView: View {
    let block: AppointmentBlock
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
            Text(block.appointment.student.name)
        }
        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 40, maxHeight: 50)
    }
}
