//
//  BimbinganModel.swift
//  mobile-logbook-mbkm
//
//  Created by Nuriansyah Malik on 08/02/23.
//

import Foundation

struct Bimbingan: Codable,Identifiable{
    let id: Int
    let name: String
    let type: String
    let status: String
}

struct Pembimbing: Codable {
    let id: Int
    let message: String
}

struct SuccessPembimbingResponse: Codable {
    let message: String
}

struct ErrorPembimbingResponse: Codable {
    let message: String
}
