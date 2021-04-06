//
//  AppAction.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

enum AppAction {
    case move(_ block: String, _ toArea: String)
    case switchSidebar(_ item: AppState.SidebarItem)
    case toggleSidebar(_ hide: Bool?)
    
    case requestStudentInfo(_ id: String)
//    case refreshStudentInfo(_ id: String)
}
