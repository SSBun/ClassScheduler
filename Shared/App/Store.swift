//
//  Store.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import Combine
import WCDBSwift
import SwiftUI

class Store: ObservableObject {
    @Published var appState: AppState = .init()
    private var bag: Set<AnyCancellable> = []
    
    init() {
        setupBinds()
    }
    
    private func setupBinds() {
        appState.studentList.search.result.sink { content in
            LOG("Search Student: \(content)")
            self.dispatch(.searchStudents(content))
        }.store(in: &bag)
    }
}

extension Store {
    func dispatch(_ action: AppAction) {
        DispatchQueue.main.async {
            LOG(category: .action, action)
            let result = Store.reduce(self.appState, action)
            self.appState = result.0
            if let command = result.1 {
                LOG(category: .command, command)
                command.execute(in: self)
            }
        }
    }
    
    static func reduce(_ state: AppState, _ action: AppAction) -> (AppState, AppCommand?) {
        var newState = state
        var command: AppCommand?
        switch action {
        case .loadApp(let initState):
            if let initState = initState {
                newState = initState
            } else {
                command = InitializeAppCommand(state: newState)
            }
        case let .moveBlock(block, to):
            newState = moveAction(newState, block, to)
        case let .switchSidebar(item):
            newState.sidebar.sidebarSelection = item
        case let .requestStudentInfo(id):
            command = RequestStudentInfoCommand(id: id)
        case .toggleSidebar(let hide):
            if let hide = hide {
                newState.sidebar.isHidden = hide
            } else {
                newState.sidebar.isHidden.toggle()
            }
        case .insertAppointment(student: let student, to: let to):
            newState = insertAppointment(newState, student, to)
        case .switchWeek(let offset):
            newState = switchWeek(newState, offset)
        case .refreshStudentInfo(let student):
            newState.studentList.studentsData[student.id] = student
            try? student.db.update(on: Student.Properties.all)
        case .searchStudents(let condition):
            if condition.count == 0 {
                newState.studentList.searchedStudents = newState.studentList.studentsData.keys.sorted()
            } else {
                if let _ = Int(condition) {
                    newState.studentList.searchedStudents = newState.studentList.studentsData.keys.filter { $0 == condition }
                } else {
                    newState.studentList.searchedStudents = newState.studentList.studentsData.values.filter({ ($0.userName ?? "").contains(condition) }).map { $0.id }.sorted()
                }
            }
        case .importStudents(let importedData):
            let insertedStudents = importedData.split(separator: "\n").map { Student(id: String($0)) }
            do {
                try Student.db.insert(insertedStudents)
                for student in insertedStudents {
                    newState.studentList.studentsData[student.id] = student
                }
                newState.studentList.search.content = ""
            } catch(_) {
                
            }
        case .toggleLessonListSidebar(let hide):
            if let hide = hide {
                newState.lessonList.isSidebarHidden = hide
            } else {
                newState.lessonList.isSidebarHidden.toggle()
            }
        case .selectStudent(let studentId):
            newState.studentList.currentStudent = studentId
        case .removeStudent(let studentId):
            do {
                try Student.db.delete(where: Student.Properties.id == studentId)
                newState.studentList.studentsData.removeValue(forKey: studentId)
                newState.studentList.search.content = ""
            } catch(_) {
                
            }
        case .selectAppointment(let lessonAppointment):
            if !newState.lessonList.appointmentDetail.isRequesting {
                newState.lessonList.appointmentDetail = LessonList.AppointmentDetail(appointment: lessonAppointment)
                newState.lessonList.isSidebarHidden = false
            } else {
                LOG(level: .warning, "This is requesting an appointment, so you can't select another appointment")
            }
        case .requestAppointment(let lessonAppointment):
            newState.lessonList.appointmentDetail.isRequestingAppointment = true
            command = RequestAppointmentCommand(appointmentId: lessonAppointment)
        case .requestAppointmentCompletion(let result):
            newState.lessonList.appointmentDetail.isRequestingAppointment = false
            newState.lessonList.appointmentDetail.requestedResult = result
            if let appointmentId = newState.lessonList.appointmentDetail.appointment,
               var appointment = newState.appointmentsData[appointmentId],
               case .success(_) = result {
                do {
                    appointment.state = .locked
                    newState.appointmentsData[appointment.id] = appointment
                    try appointment.db.update(on: LessonAppointment.Properties.all, where: LessonAppointment.Properties.id == appointment.id)
                } catch (_) {
                    
                }
            }
        case .cancelAppointment(let appointment):
            newState.lessonList.appointmentDetail.isRequestingAppointment = true
            command = CancelAppointmentCommand(appointment: appointment)
        case .cancelAppointmentCompletion(let result):
            newState.lessonList.appointmentDetail.isRequestingAppointment = false
            newState.lessonList.appointmentDetail.requestedResult = result
            if let appointmentId = newState.lessonList.appointmentDetail.appointment,
               var appointment = newState.appointmentsData[appointmentId],
               case .success(_) = result {
                do {
                    appointment.state = .normal
                    newState.appointmentsData[appointment.id] = appointment
                    try appointment.db.update(on: LessonAppointment.Properties.all, where: LessonAppointment.Properties.id == appointment.id)
                } catch (_) {
                    
                }
            }
        case .requestAppointmentInfo(student: let student):
            newState.lessonList.appointmentDetail.isRequestingInfo = true
            command = RequestAppointmentInfoCommand(student: student)
        case .requestAppointmentInfoCompletion(let result):
            newState.lessonList.appointmentDetail.isRequestingInfo = false
            newState.lessonList.appointmentDetail.requestedResult = result.map({ _ in "获取预约信息成功" })
            if var appointment = newState.appointmentsData[newState.lessonList.appointmentDetail.appointment ?? -1],
               case let .success(data) = result {
                do {
                    appointment.info = data
                    newState.appointmentsData[appointment.id] = appointment
                    try appointment.db.update(on: LessonAppointment.Properties.all, where: LessonAppointment.Properties.id == appointment.id)
                } catch (_) {
                    
                }
            }
        }
        return (newState, command)
    }
    
    static func insertAppointment(_ state: AppState, _ student: String, _ to: String) -> AppState {
        var addedIndex: (Int, Int)? = nil
        var newState = state
        for (ci, column) in state.lessonList.columns.enumerated() {
            for (ai, area) in column.areas.enumerated() {
                if area.id == to {
                    addedIndex = (ci, ai)
                    break
                }
            }
        }
        if let addedIndex = addedIndex {
            let col = newState.lessonList.columns[addedIndex.0]
            let area = col.areas[addedIndex.1]
            if case .week(let day)  = col.type, case .timeRange(let timeRange) = area.type {
                do {
                    var appointment = LessonAppointment(id: 0, day: day, timeRange: timeRange, studentId: student)
                    try appointment.db.insert()
                    appointment.id = try LessonAppointment.db.get(orderBy: [LessonAppointment.Properties.id.asOrder(by: .descending)], limit: 1, offset: 0).first!.id
                    newState.appointmentsData[appointment.id] = appointment
                    let appointmentBlock = AppointmentBlock(id: appointment.id)
                    newState.lessonList.columns[addedIndex.0].areas[addedIndex.1].items.append(appointmentBlock)
                    
                } catch(_) {
                    
                }
            }
        }
        return newState
    }
    
    static func moveAction(_ state: AppState, _ block: Int, _ to: String) -> AppState {
        let isRemoved = to == "blackhole"
        var removedIndex: (Int, Int, Int)? = nil
        var addedIndex: (Int, Int)? = nil
        var movedBlock: Block? = nil
        var newState = state
        for (ci, column) in state.lessonList.columns.enumerated() {
            column.areas.enumerated().forEach { (ai, area) in
                if area.id == to {
                    addedIndex = (ci, ai)
                }
                area.items.enumerated().forEach { (bi, blc) in
                    if blc.id == block {
                        removedIndex = (ci, ai, bi)
                        movedBlock = blc
                    }
                }
            }
            if removedIndex != nil, addedIndex != nil {
                break
            }
        }
        if isRemoved, let removedIndex = removedIndex {
            do {
                try LessonAppointment.db.delete(where: LessonAppointment.Properties.id == block)
                newState.lessonList.columns[removedIndex.0].areas[removedIndex.1].items.remove(at: removedIndex.2)
                newState.appointmentsData.removeValue(forKey: block)
            } catch(_) {
                
            }
            return newState
        }
        if let removedIndex = removedIndex, let addedIndex = addedIndex, let movedBlock = movedBlock as? AppointmentBlock {
            let col = newState.lessonList.columns[addedIndex.0]
            let area = col.areas[addedIndex.1]
            if case .week(let day)  = col.type, case .timeRange(let timeRange) = area.type, var appointment = state.appointmentsData[movedBlock.id] {
                do {
                    appointment.day = day
                    appointment.timeRange = timeRange
                    try appointment.db.update(on: LessonAppointment.Properties.all, where: LessonAppointment.Properties.id == appointment.id)
                    newState.appointmentsData[appointment.id] = appointment
                    let appointmentBlock = AppointmentBlock(id: appointment.id)
                    newState.lessonList.columns[addedIndex.0].areas[addedIndex.1].items.append(appointmentBlock)
                    newState.lessonList.columns[removedIndex.0].areas[removedIndex.1].items.remove(at: removedIndex.2)
                } catch(_) {
                    
                }
            }
        }
        return newState
    }
    
    static func switchWeek(_ state: AppState, _ weekOffset: Int) -> AppState {
        var newState = state
        var columns: [LessonList.Column] = []
        for day in CourseCalendar.getWeek(weekOffset).days {
            var areas: [LessonList.ColumnArea] = []
            for timeRange in TimeRanges.allCases {
                do {
                    let appointments =
                        try LessonAppointment.db.get(on: LessonAppointment.Properties.all,
                                                     where: LessonAppointment.Properties.timeRange == timeRange
                                                        && LessonAppointment.Properties.day == day)
                    appointments.forEach {
                        newState.appointmentsData[$0.id] = $0
                    }
                    let blocks = appointments.map { AppointmentBlock(id: $0.id) }
                    areas.append(.init(type: .timeRange(timeRange), columnType: .week(day) , items: blocks))
                } catch(let error) {
                    LOG(level: .error, category: .database, error)
                }
            }
            columns.append(.init(type: .week(day), areas: areas))
        }
        newState.lessonList.columns = columns
        newState.lessonList.weekOffset = weekOffset
        return newState
    }
    
}
