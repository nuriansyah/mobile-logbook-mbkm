//
//  UserModel.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 02/02/23.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let dosen_name: String
    let nama: String
    let nrp: String
    let company: String
    let program_km: String
    let learn_path: String
    let batch: Int

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case dosen_name = "dosen_name"
        case nama = "nama"
        case nrp = "nrp"
        case company = "company"
        case program_km = "program_km"
        case learn_path = "learn_path"
        case batch = "batch"
    }
}

struct Dosen: Codable,Identifiable{
    let id: Int
    let name: String
    let email: String
}

struct Mahasiswa: Codable {
    let id: Int?
    var company: String
    var programKM: String
    var learnPath: String
    var batch: Int
}


struct MahasiswaDetail: Codable {
    let id: Int
    let name: String
    let nrp: String
    let company: String
    let programKM: String
    let learnPath: String
    let batch: Int
    let reportDetails: [ReportDetail]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nama"
        case nrp
        case company
        case programKM = "program_km"
        case learnPath = "learn_path"
        case batch
        case reportDetails = "details"
    }
}

struct ReportDetail: Codable {
    let reportID: Int
    var title: String
    var content: String
    var status: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case reportID = "ReportID"
        case title
        case content
        case status
        case createdAt = "created_at"
    }
}

