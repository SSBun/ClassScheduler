//
//  StudentListView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct StudentListView: View {
    @EnvironmentObject var store: Store
    var body: some View {
        HStack {
            StudentSelector(canDrag: false)
            StudentDetailView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }   
        .background(Color("background"))
    }
}

struct StudentListView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView()
    }
}
