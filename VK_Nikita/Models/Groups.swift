//
//  Groups.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit
import RealmSwift

// MARK: - Item
class Groups: Object, Codable {
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_100"
    }
}

