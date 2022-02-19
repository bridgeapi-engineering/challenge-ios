//
//  BankModel.swift
//  TestBankin
//
//  Created by Alex on 19/02/2022.
//

import Foundation

struct GetBanksResponse: Codable {
    let resources: [Bank]
}

struct Bank: Codable {
    let id: Int
    let countryCode: String
    let name: String
    let primaryColor: String?
    let logoUrl: String?
}
