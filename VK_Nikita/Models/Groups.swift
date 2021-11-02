//
//  Groups.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

// MARK: - Item
struct Groups: Codable {
    let name: String
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_100"
    }
}

