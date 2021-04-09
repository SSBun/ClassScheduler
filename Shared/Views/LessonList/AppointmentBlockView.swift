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
    
    var body: some View {
        content
        .onDrag({ DragDropData(block).itemProvider })
    }
    
    @ViewBuilder
    var content: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
            Text(block.appointment.student.name)
        }
        .frame(minWidth: 20, maxWidth: .infinity, maxHeight: 40)
        .cornerRadius(5)
        .padding(.horizontal, 5)
    }
}

struct AppointmentBlockView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentBlockView(block: .init(appointment: .init(day: .init(date: .init()), timeRange: .four, student: .mock)))
    }
}