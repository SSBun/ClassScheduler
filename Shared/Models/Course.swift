//
//  Course.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/15.
//

import Foundation
import WCDBSwift

struct Course {
    var id: Int
    var title: String
    var evaluations: [String]
    
    static let mock: Self = .init(id: 0, title: "拯救源码蛋岛", evaluations: ["本节课完成了全部课内任务，任务一疯狂的装置，认识旋转积木，旋转积木修改数值可以控制旋转速度，掌握顺时针旋转与逆时针旋转。任务二疯狂的能量核，结合生活理解旋转的中心点，并且理解自转和围绕他人旋转的区别：中心点不同，任务三灰灰鼠乱跑，理解设置旋转模式，并且掌握了循环结构重复执行。任务四发射炮弹，孩子发散自己的思维使用学习过的积木自己组合实现效果，并且理清思路自己修改积木提升游戏难度"])
    
    var isAutoIncrement: Bool { true }
}

extension Course: Codable, DBTable {
    static var tableName: String = "t_course"
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Course
        
        case id = "id"
        case title = "title"
        case evaluations = "evaluations"
                
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        static var columnConstraintBindings: [Course.CodingKeys : ColumnConstraintBinding]? {
            return [id: .init(isPrimary: true, isAutoIncrement: true)]
        }
    }
}
