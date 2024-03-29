//
//  ReportModel.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 03/02/23.
//

import Foundation

struct Report: Identifiable, Decodable {
    let id: Int?
    var title: String
    var content: String
    let type: String
    let status: String
    let dosen_id: Int
    let status_id: Int
    let created_at: String
    let message: String
}


struct PendingReportsResponse: Codable {
    let pending: [Report]
    let countPending: CountPending
    
    enum CodingKeys: String, CodingKey {
        case pending
        case countPending = "count_pending"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(countPending, forKey: .countPending)
    }
}


struct ApprovedReportsResponse: Codable {
    let accepted: [Report]
    let countApproved: CountApproved
    
    enum CodingKeys: String, CodingKey {
        case accepted
        case countApproved = "count_accepted"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(countApproved, forKey: .countApproved)
    }
}

struct RejectedReportsResponse: Codable {
    let reject: [Report]
    let countRejected: CountRejected
    
    enum CodingKeys: String, CodingKey {
        case reject
        case countRejected = "count_rejected"
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(countRejected, forKey: .countRejected)
    }
}


struct CountPending: Codable {
    let pending: Int
}
struct CountApproved: Codable {
    let accepted: Int
}
struct CountRejected: Codable {
    let reject: Int
}

struct Reports: Codable, Identifiable {
    let id: Int
    let title: String
    let content: String
    let createdAt: String
    let type: String
    let status: String
    let statusId: Int
    let pembimbingId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case createdAt = "created_at"
        case type
        case status
        case statusId = "status_id"
        case pembimbingId = "pembimbing_id"
    }
}

struct RequestReporting: Codable {
    var title: String
    var content: String
}

struct ResponseInsertReporting: Codable {
    var id: Int
    var message: String
}

struct SuccessReportingResponse: Codable {
    var message: String
}
struct UploadResponse: Decodable {
    let message: String
}
struct EditReportRequest: Codable {
    let title: String
    let content: String
}

