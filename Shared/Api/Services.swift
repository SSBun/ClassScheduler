//
//  Services.swift
//  ClassScheduler (iOS)
//
//  Created by caishilin on 2021/4/6.
//

import Foundation
import Moya

enum Services {
    case info(id: String)
    
    case getSubjects(studentId: String)
    case getAllTracks(subjectId: Int)
    case getCurrentTrack(studentId: String, subjectId: Int)
    case getAllPoints(trackId: Int)
    case getCurrentPoint(studentId: String, trackId: Int)
    case appointment(studentId: String, teacherId: Int, subjectId: Int, trackId: Int, pointId: Int, time: Int)
}

// MARK: - Student Services
extension Services: TargetType {
    var baseURL: URL {
        switch self {
        case .info(id: _):
            return URL(string: "https://cloud-gateway.codemao.cn")!
        case .getSubjects(studentId: _),
             .getAllTracks(subjectId: _),
             .getCurrentTrack(studentId: _, subjectId: _),
             .getAllPoints(trackId: _),
             .getCurrentPoint(studentId: _, trackId: _):
            return URL(string: "https://api-education-codemaster.codemao.cn")!
        case .appointment(studentId: _, teacherId: _, subjectId: _, trackId: _, pointId: _, time: _):
            return URL(string: "https://api-attendance-codemaster.codemao.cn")!
        }
    }
    
    var path: String {
        switch self {
        case .info(id: let id):
            return "/api-crm-web/admin/users/\(id)"
        case .getSubjects(studentId: let studentId):
            return "/admin/lessons/student-position/users/\(studentId)/subjects"
        case .getAllTracks(subjectId: let subjectId):
            return "/admin/lessons/knowledge/subjects/\(subjectId)/tracks/all"
        case .getCurrentTrack(studentId: let studentId, subjectId: _):
            return "/admin/lessons/student-position/users/\(studentId)/tracks"
        case .getAllPoints(trackId: let trackId):
            return "/admin/lessons/knowledge/tracks/\(trackId)/points/all"
        case .getCurrentPoint(studentId: let studentId, trackId: _):
            return "/admin/lessons/student-position/users/\(studentId)/points"
        case .appointment(studentId: _, teacherId: _, subjectId: _, trackId: _, pointId: _, time: _):
            return "/attendances/inside"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .info(id: _),
             .getSubjects(studentId: _),
             .getAllTracks(subjectId: _),
             .getCurrentTrack(studentId: _, subjectId: _),
             .getAllPoints(trackId: _),
             .getCurrentPoint(studentId: _, trackId: _):
            return .get
        case .appointment(studentId: _, teacherId: _, subjectId: _, trackId: _, pointId: _, time: _):
            return .post
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .info(id: _),
             .getSubjects(studentId: _),
             .getAllTracks(subjectId: _),
             .getAllPoints(trackId: _):
            return .requestPlain
        case .getCurrentTrack(studentId: _, subjectId: let subjectId):
            return .requestParameters(parameters: ["subject_id": subjectId], encoding: URLEncoding.queryString)
        case .getCurrentPoint(studentId: _, trackId: let trackId):
            return .requestParameters(parameters: ["track_id": trackId], encoding: URLEncoding.queryString)
        case .appointment(studentId: let studentId,
                          teacherId: let teacherId,
                          subjectId: let subjectId,
                          trackId: let trackId,
                          pointId: let pointId,
                          time: let time):
            return .requestParameters(parameters: ["subject_id": subjectId,
                                                   "student_id": studentId,
                                                   "track_id": trackId,
                                                   "time_slot": time,
                                                   "point_id": pointId,
                                                   "teacher_id": teacherId],
                                      encoding: JSONEncoding())
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "authorization_type": "3",
                "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36",
                "Cookie": Teacher.mock.token ?? ""]
    }
}

// MARK: - Appointment


// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
