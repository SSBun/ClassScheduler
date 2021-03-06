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
        VStack {
            switch tagData {
            case .timeRange(let range):
                Text("\(range.range.0)")
                    .font(.headline)
            }
        }
        .frame(maxWidth: 40, maxHeight: .infinity)
        .background(Color("ruler_bar"))
    }
}

struct VTagView_Previews: PreviewProvider {
    static var previews: some View {
        VTagView(tagData: .timeRange(.one))
    }
}
