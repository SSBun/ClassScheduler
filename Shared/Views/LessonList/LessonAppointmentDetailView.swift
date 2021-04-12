//
//  LessonAppointmentDetailView.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/12.
//

import SwiftUI

struct LessonAppointmentDetailView: View {
    
    private var infos: [(String, String?)] {
        [("姓名", "ssbun"),
        ("课程", "AAAfsfdsfsdfsdfsdfsdfA课程"),
        ("课节", "aaaaa课节"),
        ("时间", "2021-03-23 周日"),
        ("老师", "大象在天上飞")]
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                ForEach(infos, id: \.0) { info in
                    InfoCell(title: info.0, value: info.1)
                        .frame(maxWidth: .infinity, minHeight: 40)
                }
            }
        }
        .frame(minWidth: 200, maxWidth: 200, maxHeight: .infinity)
        .background(Color("student_list_bg"))
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: -2, y: 2)
    }
}

extension LessonAppointmentDetailView {
    struct InfoCell: View {
        let title: String
        let value: String?
        
        var body: some View {
            HStack(alignment: .top) {
                Label("\(title): ", image: "")
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .foregroundColor(Color.white.opacity(0.5))
                Text(value ?? "null")
                    .font(.system(size: 16, weight: .heavy, design: .default))
                    .lineLimit(3)
                    .foregroundColor(Color.white.opacity(0.8))
                Spacer()
            }
        }
    }
}
