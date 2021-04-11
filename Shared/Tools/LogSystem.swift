//
//  LogSystem.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/9.
//

import Foundation

enum LogSystem {
    enum Level: Int {
        case none
        case debug
        case warning
        case error
        
        var name: String {
            switch self {
            case .none:
                return ""
            case .debug:
                return "[DEBUG]"
            case .warning:
                return "[WARNING]"
            case .error:
                return "[ERROR]"
            }
        }
    }
    
    enum Category {
        case none
        case action
        case command
        case message
        case database
        
        var name: String {
            switch self {
            case .none:
                return ""
            case .action:
                return "[ACTION]"
            case .command:
                return "[COMMAND]"
            case .message:
                return "[MESSAGE]"
            case .database:
                return "[DATABASE]"
            }
        }
    }
    
    static func echo(_ level: Level, _ category: Category, _ content: String) {
        echo("\(category.name)\(level.name): \(content)")
    }
    
    static func echo(_ msg: String) {
        #if DEBUG
        print(msg)
        #endif
    }
}


func LOG(level: LogSystem.Level = .none, category: LogSystem.Category = .message, _ content: Any?) {
    LogSystem.echo(level, category, content == nil ? "nil" : "\(content!)")
}
