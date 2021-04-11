//
//  ImportStudentView.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/10.
//

import SwiftUI

struct ImportStudentView: View {
    @EnvironmentObject var store: Store
    @Binding var isPresented: Bool
    @State private var content: String = ""
    
    private let placeholderString = """
    一个 ID 一行,例子如下:

    890432
    392090
    420384
    """
    
    var body: some View {
        VStack {
            Text("导入学生ID")
                .font(.title2)
                .padding(.top, 5)
            MacTextView(text: $content, backgroundColor: NSColor(named: "import_student_text_bg"), placeholder: placeholderString)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.all, 10)
                .background(Color("import_student_text_bg"))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            HStack {
                generateButton("取消", Color.gray.opacity(0.3)) {
                    self.isPresented = false
                }
                Spacer()
                generateButton("导入", Color.red.opacity(0.6)) {
                    store.dispatch(.importStudents(content))
                    self.isPresented = false                    
                }
            }
            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
        }
        .frame(width: 500, height: 500)
    }
    
    func generateButton(_ title: String, _ bgColor: Color, _ clickHandle: @escaping () -> Void) -> some View {
        Button {
            clickHandle()
        } label: {
            Text(title)
                .frame(minWidth: 200, maxHeight: .infinity)
                .background(bgColor)
        }
        .buttonStyle(PlainButtonStyle())
        .cornerRadius(20)
    }
}

struct ImportStudentView_Previews: PreviewProvider {
    @State static private var isPresented: Bool = true
    static var previews: some View {
        ImportStudentView(isPresented: $isPresented)
    }
}
