//
//  BankModel.swift
//  TestBankin
//
//  Created by Alex on 19/02/2022.
//

import Foundation

struct GetBanksResponse: Codable {
    let resources: [Bank]
    let pagination: Pagination
}

struct Bank: Codable {
    let id: Int
    let countryCode: String
    let name: String
    let primaryColor: String?
    let logoUrl: String?
}

struct Pagination: Codable {
    let nextUri: String?
}
