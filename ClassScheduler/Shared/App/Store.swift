//
//  Store.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation

class Store: ObservableObject {
    @Published var appState: AppState = .init()
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
        case let .move(block, to):
            newState = moveAction(newState, block, to)
            command = nil
        case let .switchSidebar(item):
            newState.sidebarSelection = item
        }
        return (newState, command)
    }
    
    static func moveAction(_ state: AppState, _ block: String, _ to: String) -> AppState {
        var removedIndex: (Int, Int, Int)? = nil
        var addedIndex: (Int, Int)? = nil
        var movedBlock: Block? = nil
        var newState = state
        for (ci, column) in state.lessonList.columns.enumerated() {
            column.areas.enumerated().forEach { (ai, area) in
                if area.id == to {
                    addedIndex = (ci, ai)
                }
                area.items.enumerated().forEach { (bi, blc) in
                    if blc.id == block {
                        removedIndex = (ci, ai, bi)
                        movedBlock = blc
                    }
                }
            }
            if removedIndex != nil, addedIndex != nil {
                break
            }
        }
        if let removedIndex = removedIndex, let addedIndex = addedIndex, let movedBlock = movedBlock {
            newState.lessonList.columns[removedIndex.0].areas[removedIndex.1].items.remove(at: removedIndex.2)
            newState.lessonList.columns[addedIndex.0].areas[addedIndex.1].items.append(movedBlock)
        }
        return newState
    }
}
