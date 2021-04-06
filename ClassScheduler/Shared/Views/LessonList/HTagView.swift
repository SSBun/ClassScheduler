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
            Text("\(tagData.id)")
        }
        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
        .background(Color.black)
    }
}

struct HTagView_Previews: PreviewProvider {
    static var previews: some View {
        HTagView(tagData: .week(.monday))
    }
}
