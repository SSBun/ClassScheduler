//
//  VTagView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/6.
//

import SwiftUI

struct VTagView: View {
    let tagData: LessonList.ColumnAreaType
    
    var body: some View {
        ZStack {
            Text("\(tagData.id)")
        }
        .frame(maxWidth: 40, maxHeight: .infinity)
        .background(Color.black)
    }
}

struct VTagView_Previews: PreviewProvider {
    static var previews: some View {
        VTagView(tagData: .timeRange(.one))
    }
}
