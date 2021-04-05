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
        ZStack {
            Rectangle()
                .fill(Color.gray)
            HStack {
                StudentSelector()                    
                StudentDetailView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct StudentListView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView()
    }
}
