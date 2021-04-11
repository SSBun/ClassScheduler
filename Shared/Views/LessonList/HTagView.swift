//
//  HTagView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/6.
//

import SwiftUI

struct HTagView: View {
    let tagData: LessonList.ColumnType
    
    var body: some View {
        ZStack {
            switch tagData {
            case .week(let day):
                VStack {
                    Text("\(day.date.toString(.custom("YYYY-MM-dd")))")
                        .font(.subheadline)
                    Text("\(day.date.weekdayName(.short))")
                        .font(.headline)
                    
                }
            }
        }        
        .background(Color("ruler_bar"))
    }
}

struct HTagView_Previews: PreviewProvider {
    static var previews: some View {
        HTagView(tagData: .week(.init(date: .init())))
    }
}
