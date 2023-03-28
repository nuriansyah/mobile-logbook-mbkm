//
//  CommentModel.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 25/03/23.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let mhsName: String?
    let dosenName: String?
    let comments: String
    let postID: Int
    let createdAt: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case mhsName = "mhs_name"
        case dosenName = "dosen_name"
        case comments
        case postID = "post_id"
        case createdAt = "created_at"
        case type = "types"
    }
}







