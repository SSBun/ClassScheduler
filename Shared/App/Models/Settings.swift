//
//  Settings.swift
//  ClassScheduler (macOS)
//
//  Created by SSBun on 2021/5/28.
//

import Foundation

struct Settings {
    var isPresented: Bool = false
    var repeatTimesOfInsertingAnAppointment: Int = 1 {
        didSet {
            if repeatTimesOfInsertingAnAppointment < 1 {
                repeatTimesOfInsertingAnAppointment = 1
            }
        }
    }
}
