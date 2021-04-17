//
//  LessonAppointmentDetailView.swift
//  ClassScheduler
//
//  Created by caishilin on 2021/4/12.
//

import SwiftUI

struct LessonAppointmentDetailView: View {
    @EnvironmentObject var store: Store
    
    private var detailInfo: LessonList.AppointmentDetail { store.appState.lessonList.appointmentDetail }
    private var appointment: LessonAppointment? { store.appState.appointmentsData[detailInfo.appointment ?? -1] }
    private var student: Student? { store.appState.studentList.studentsData[appointment?.studentId ?? ""] }
    
    private var infos: [(String, String?)] {
        var openningTimeString = ""
        if let openningTime = appointment?.openningTime {
            openningTimeString += "\(openningTime.weekdayName(.short))"
            openningTimeString += "\(openningTime.toFormat("HH:mm"))  "
            openningTimeString += "\(openningTime.monthName(.default))"
            openningTimeString += "\(openningTime.day)号 "
        }
        return [("姓名", [student?.fullName, student?.nickName, student?.userName].compactMap({$0}).filter({ $0.count > 0 }).first),
                ("系列", appointment?.info?.subject.name),
                ("课程", appointment?.info?.track.name),
                ("课节", appointment?.info?.point.name),
                ("时间", openningTimeString),
                ("老师", Teacher.mock.name)]
    }
    
    var body: some View {
        ScrollView(.vertical) {
            if let appointment = appointment, let student = student {
                VStack(alignment: .leading) {
                    Text("预约信息")
                        .foregroundColor(Color.white.opacity(0.5))
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                    ForEach(infos, id: \.0) { info in
                        InfoCell(title: info.0, value: info.1)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .padding(.horizontal, 10)
                    }
                    Button {
                        store.dispatch(.requestAppointmentInfo(student: student.id))
                    } label: {
                        Group {
                            if detailInfo.isRequestingInfo {
                                IndicatorView()
                            } else {
                                Text("刷新预约信息")
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                        .background(Color("student_block_bg_noinfo").opacity(0.8))
                        .cornerRadius(10)
                    }
                    .disabled(detailInfo.isRequesting || appointment.state == .locked)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 10)
                    .padding(.top, 30)
                    Button {
                        if appointment.state == .normal {
                            store.dispatch(.requestAppointment(appointment.id))
                        } else {
                            store.dispatch(.cancelAppointment(appointment.id))
                        }
                    } label: {
                        Group {
                            if detailInfo.isRequestingAppointment {
                                IndicatorView()
                            } else {
                                if appointment.state == .normal {
                                    Text("预约课程")
                                } else {
                                    Text("标记为未预约")
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                        .background(appointment.state == .normal ? Color.blue.opacity(0.8) : Color.red.opacity(0.8))
                        .cornerRadius(10)
                    }
                    .disabled(detailInfo.isRequesting || appointment.info == nil)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                }
            }
        }
        .frame(minWidth: 250, maxWidth: 250, maxHeight: .infinity)
        .background(Color("student_list_bg"))
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: -2, y: 2)
        .alert(item: $store.appState.lessonList.appointmentDetail.requestedResult) { result in
            switch result {
            case .success(let title):
                return Alert(title: Text(title))
            case .failure(let error):
                return Alert(title: Text(error.title))
            }
        }
    }
}

extension LessonAppointmentDetailView {
    struct InfoCell: View {
        let title: String
        let value: String?
        
        var body: some View {
            HStack(alignment: .top) {
                Text("\(title): ")
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .foregroundColor(Color.white.opacity(0.5))
                Text(value ?? "请获取预约信息")
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                    .lineLimit(3)
                    .foregroundColor(value == nil ? Color.red.opacity(0.8) : Color.white.opacity(0.8))
                Spacer()
            }
        }
    }
}


extension Result: Identifiable where Success == String, Failure: Error {
    public var id: String {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            return error.localizedDescription
        }
    }
}
