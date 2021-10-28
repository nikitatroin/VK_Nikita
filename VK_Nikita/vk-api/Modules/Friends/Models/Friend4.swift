//
//  Friend4.swift
//  VK_Nikita
//
//  Created by Никита Троян on 28.10.2021.
//

import Foundation


// MARK: - Item
struct Friend4: Codable {
    let id: Int
    let lastName: String
    let firstName: String
    let photo100: String

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
}
