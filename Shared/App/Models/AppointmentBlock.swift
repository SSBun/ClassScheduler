//
//  AppointmentBlock.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import SwiftUI

struct AppointmentBlock: Block, Codable {
    var id: Int { appointment.id }
    let appointment: LessonAppointment
}

extension AppointmentBlock: DragDropAvailable {
    static let dataIdentifier: String = "AppointmentBlock"
}
