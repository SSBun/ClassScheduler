//
//  Student.swift
//  ClassScheduler
//
//  Created by SSBun on 2021/4/5.
//

import Foundation
import WCDBSwift

struct Student: Codable, Identifiable {
    var id: String
    var userName: String? = nil
    var nickName: String? = nil
    var fullName: String? = nil
    var customerId: String? = nil
    var sex: Int? = nil
    var cityName: String? = nil
    var provinceName: String? = nil
    var age: Int? = nil
    var birthday: Int? = nil
    var grade: Int? = nil
    var email: String? = nil
    var channelSourceName: String? = nil
    var channelName: String? = nil
    var channelId: Int? = nil
    var channelSourceId: Int? = nil
    var schoolName: String? = nil
    var refereeId: String? = nil
    var applicant: Int? = nil
    var applicantPhoneNumber: String? = nil
    var parentsInfo: ParentsInfo? = nil
    var importDate: Int? = nil
    var firstImportDate: Int? = nil
    var createdAt: Int? = nil
    var registerUrl: String? = nil
    var category: String? = nil
    var subcategory: String? = nil
    var subcategoryComment: String? = nil
    var comment: String? = nil
    var interestClasses: String? = nil
    var customerStateName: String? = nil
    var lastFollowUpTime: Int? = nil
    var nextFollowUpTime: Int? = nil
    var skill: Skill? = nil
    var presentMonthTicketTakenNum: Int? = nil
    var daysNotAttendClass: Int? = nil
    var ticketTakenNum: Int? = nil
    var remainTicketNum: Int? = nil
    var lastAttendClassDate: Int? = nil
    var currentLessonPosition: [CurrentLessonPosition]? = nil
    var userTags: [UserTag]? = nil
    var headTeacherName: String? = nil
    var counselorName: String? = nil
    var communityCounselorName: String? = nil
    var headTeacherWxQrCodeUrl: String? = nil
    var counselorWxQrCodeUrl: String? = nil
    var clueFlowType: Int? = nil
    var currentLoginFlag: String? = nil
    var wechatNickname: String? = nil
    var wechatAvatarUrl: String? = nil
    var clueFlowChannel: Int? = nil
    var serviceModel: Int? = nil
    
}

extension Student: DragDropAvailable {
    static let dataIdentifier: String = "Student"
}

extension Student: DBTable {
    static let tableName = "t_student"
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Student
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case id = "user_id"
        case userName = "user_name"
        case nickName = "nick_name"
        case fullName = "full_name"
        case customerId = "customer_id"
        case sex = "sex"
        case cityName = "city_name"
        case provinceName = "province_name"
        case age = "age"
        case birthday = "birthday"
        case grade = "grade"
        case email = "email"
        case channelSourceName = "channel_source_name"
        case channelName = "channel_name"
        case channelId = "channel_id"
        case channelSourceId = "channel_source_id"
        case schoolName = "school_name"
        case refereeId = "referee_id"
        case applicant = "applicant"
        case applicantPhoneNumber = "applicant_phone_number"
        case parentsInfo = "parents_info"
        case importDate = "import_date"
        case firstImportDate = "first_import_date"
        case createdAt = "created_at"
        case registerUrl = "register_url"
        case category = "category"
        case subcategory = "subcategory"
        case subcategoryComment = "subcategory_comment"
        case comment = "comment"
        case interestClasses = "interest_classes"
        case customerStateName = "customer_state_name"
        case lastFollowUpTime = "last_follow_up_time"
        case nextFollowUpTime = "next_follow_up_time"
        case skill = "skill"
        case presentMonthTicketTakenNum = "present_month_ticket_taken_num"
        case daysNotAttendClass = "days_not_attend_class"
        case ticketTakenNum = "ticket_taken_num"
        case remainTicketNum = "remain_ticket_num"
        case lastAttendClassDate = "last_attend_class_date"
        case currentLessonPosition = "current_lesson_position"
        case userTags = "user_tags"
        case headTeacherName = "head_teacher_name"
        case counselorName = "counselor_name"
        case communityCounselorName = "community_counselor_name"
        case headTeacherWxQrCodeUrl = "head_teacher_wx_qr_code_url"
        case counselorWxQrCodeUrl = "counselor_wx_qr_code_url"
        case clueFlowType = "clue_flow_type"
        case currentLoginFlag = "current_login_flag"
        case wechatNickname = "wechat_nickname"
        case wechatAvatarUrl = "wechat_avatar_url"
        case clueFlowChannel = "clue_flow_channel"
        case serviceModel = "service_model"
        
        static var columnConstraintBindings: [Student.CodingKeys : ColumnConstraintBinding]? {
            return [id: .init(isPrimary: true, onConflict: .replace)]
        }
    }
}
