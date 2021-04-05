//
//  AppCommand.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation


protocol AppCommand {
    func execute(in store: Store)
}
