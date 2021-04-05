//
//  Store.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

class Store: ObservableObject {
    var appState: AppState = .init()
    
    
}

extension Store {
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        let result = Store.reduce(appState, action)
        appState = result.0
        
        if let command = result.1 {
            #if DEBUG
            print("[COMMAND]: \(command)")
            #endif
            command.execute(in: self)
        }
    }
    
    static func reduce(_ state: AppState, _ action: AppAction) -> (AppState, AppCommand?) {
        var newState = state
        var command: AppCommand?
        switch action {
        }
        return (newState, command)
    }
}
