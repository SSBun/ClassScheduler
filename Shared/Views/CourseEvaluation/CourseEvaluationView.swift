//
//  CourseEvaluationView.swift
//  ClassScheduler (iOS)
//
//  Created by SSBun on 2021/4/5.
//

import SwiftUI

struct CourseEvaluationView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        HSplitView {
            StudentSelector(canDrag: false, topOffset: 5)
            ZStack(alignment: .bottomTrailing) {
                MacTextView(text: $store.appState.courseEvaluation.result, backgroundColor: NSColor(named: "import_student_text_bg"), placeholder: "")
                    .padding(.all, 10)
                    .background(Color("import_student_text_bg"))
                    .cornerRadius(4)
                    .padding(10)
                    .frame(minWidth: 300, maxHeight: .infinity)
                Button {
                    let pastedBoard = NSPasteboard.general
                    pastedBoard.declareTypes([.string], owner: nil)
                    pastedBoard.setString(store.appState.courseEvaluation.result, forType: .string)
                } label: {
                    Label("复制", systemImage: "doc.on.doc.fill")
                        .frame(width: 100, height: 40)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 10))
                }.buttonStyle(PlainButtonStyle())
            }
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center, spacing: 20) {
                        titleLabel("课程名称")
                        Button {
                            store.dispatch(.updateCourse(store.appState.courseEvaluation.currentCourse))
                        } label: {
                            Image(systemName: "arrow.clockwise.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.orange)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .padding([.leading, .top], 10)
                    MacTextView(text: $store.appState.courseEvaluation.infoObserver.courseTitle, backgroundColor: NSColor(named: "import_student_text_bg"), placeholder: "")
                        .padding(.all, 10)
                        .background(Color("import_student_text_bg"))
                        .cornerRadius(4)
                        .padding(10)
                        .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                    titleLabel("完成情况")
                        .padding(.leading, 10)
                    MacTextView(text: $store.appState.courseEvaluation.infoObserver.courseContent, backgroundColor: NSColor(named: "import_student_text_bg"), placeholder: "")
                        .padding(.all, 10)
                        .background(Color("import_student_text_bg"))
                        .cornerRadius(4)
                        .padding(10)
                        .frame(maxWidth: .infinity, minHeight: 150)
                    VStack(alignment: .leading) {
                        HStack(alignment: .center, spacing: 20) {
                            titleLabel("课堂表现")
                            Button {
                                store.dispatch(.updateCoursePerformance(store.appState.courseEvaluation.selectedPerformance))
                            } label: {
                                Image(systemName: "arrow.clockwise.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.orange)
                            }.buttonStyle(PlainButtonStyle())
                        }
                        .padding(.leading, 10)
                        .padding(.top, 30)
                        Selector(items: store.appState.courseEvaluation.coursePerformances.values.map{ Selector.Item(id: $0.id, title: $0.content) }.sorted(by: {
                            $0.id < $1.id
                        }),
                        selectedItemId: store.appState.courseEvaluation.selectedPerformance) { itemId in
                            store.dispatch(.selectCoursePerformance(itemId))
                        } addNewHandle: {
                            store.dispatch(.updateCoursePerformance(nil))
                        } removingHandle: { itemId in
                            store.dispatch(.removeCoursePerformance(itemId))
                        }
                        .frame(maxWidth: .infinity, minHeight: 35, maxHeight: 35)
                        .padding(.init(top: 15, leading: 10, bottom: 5, trailing: 10))
                        MacTextView(text: $store.appState.courseEvaluation.infoObserver.coursePerformance, backgroundColor: NSColor(named: "import_student_text_bg"), placeholder: "")
                            .padding(.all, 10)
                            .background(Color("import_student_text_bg"))
                            .cornerRadius(4)
                            .padding(10)
                            .frame(maxWidth: .infinity, minHeight: 150)
                    }
                    VStack(alignment: .leading) {
                        HStack(alignment: .center, spacing: 20) {
                            titleLabel("老师寄语")
                            Button {
                                store.dispatch(.updateTeacherMessage(store.appState.courseEvaluation.selectedMessage))
                            } label: {
                                Image(systemName: "arrow.clockwise.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.orange)
                            }.buttonStyle(PlainButtonStyle())
                        }
                        .padding(.leading, 10)
                        Selector(items: store.appState.courseEvaluation.teacherMessages.values.map{ Selector.Item(id: $0.id, title: $0.content) }.sorted(by: {
                            $0.id < $1.id
                        }),
                        selectedItemId: store.appState.courseEvaluation.selectedMessage) { itemId in
                            store.dispatch(.selectTeachingMessage(itemId))
                        } addNewHandle: {
                            store.dispatch(.updateTeacherMessage(nil))
                        } removingHandle: { itemId in
                            store.dispatch(.removeTeacherMessage(itemId))
                        }
                        .frame(maxWidth: .infinity, minHeight: 35, maxHeight: 35)
                        .padding(.init(top: 15, leading: 10, bottom: 5, trailing: 10))
                        MacTextView(text: $store.appState.courseEvaluation.infoObserver.teacherMessage, backgroundColor: NSColor(named: "import_student_text_bg"), placeholder: "")
                            .padding(.all, 10)
                            .background(Color("import_student_text_bg"))
                            .cornerRadius(4)
                            .padding(10)
                            .frame(maxWidth: .infinity, minHeight: 150)
                    }
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
    
    @ViewBuilder
    private func titleLabel(_ title: String) -> some View {
        Text(title)
            .font(.largeTitle)
    }
}

extension CourseEvaluationView {
    struct Selector: View {
        struct Item: Identifiable {
            let id: Int
            let title: String
        }
        
        var items: [Item]
        var selectedItemId: Int
        var selectingHandle: (Int) -> Void
        var addNewHandle: () -> Void
        var removingHandle: (Int) -> Void
        
        @State private var removingMessage: Int?
        
        var body: some View {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(items) { item in
                        ZStack {
                            Text(item.title.split(separator: "\n").first ?? "无名")
                                .frame(maxHeight: .infinity)
                                .padding(.horizontal, 20)
                            RightClickableView {
                            } rightMouseClickHandle: {
                                removingMessage = item.id
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: 6).fill(item.id == selectedItemId ? Color.orange : Color.gray))
                        .onTapGesture {
                            selectingHandle(item.id)
                        }
                    }
                    Image(systemName: "plus")
                        .frame(maxHeight: .infinity)
                        .padding(.horizontal, 20)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.blue))
                        .onTapGesture {
                            addNewHandle()
                        }
                }
                .alert(item: $removingMessage) { message in
                    Alert(title: Text("要删除吗"), message: nil, primaryButton: .default(Text("确定"), action: {
                        removingHandle(message)
                    }), secondaryButton: .cancel(Text("取消")))
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        CourseEvaluationView()
    }
}
