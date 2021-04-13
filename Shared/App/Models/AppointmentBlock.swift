//
//  AppointmentBlock.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import SwiftUI

struct AppointmentBlock: Block, Codable {
    /// This is the id of the wrapped lesson appointment.
    var id: Int
}

extension AppointmentBlock: DragDropAvailable {
    static let dataIdentifier: String = "AppointmentBlock"
}
