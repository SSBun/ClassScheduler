//
//  CourseEvaluationView.swift
//  ClassScheduler (iOS)
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct CourseEvaluationView: View {
    @State private var content: String = ""
    
    var body: some View {
        HSplitView {
            MacTextView(text: $content, backgroundColor: NSColor(named: "import_student_text_bg"), placeholder: "")
                .padding(.all, 10)
                .background(Color("import_student_text_bg"))
                .cornerRadius(4)
                .padding(10)
                .frame(minWidth: 300, maxHeight: .infinity)
            HStack(spacing: 0) {
                VStack {
                    Text("123")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("background"))
                CourseListView()
            }
            .frame(minWidth: 300, maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("student_list_bg"))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        CourseEvaluationView()
    }
}
