//
//  Friend3.swift
//  VK_Nikita
//
//  Created by Никита Троян on 28.10.2021.
//

import Foundation

// MARK: - FriendJSON
struct FriendJSON: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Friend3]
}

// MARK: - Item
struct Friend3: Codable {
    let id: Int
    let lastName: String
    let photo50: String
    let trackCode, firstName: String
    let photo100: String

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
}
