//
//  AppointmentBlock.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import SwiftUI

struct AppointmentBlock: Block, Codable {
    let id: String
    let appointment: LessonAppointment
}


