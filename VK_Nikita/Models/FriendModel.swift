//
//  Friend4.swift
//  VK_Nikita
//
//  Created by Никита Троян on 28.10.2021.
//

import Foundation
import RealmSwift

class FriendModel: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var lastName = ""
    @objc dynamic var firstName = ""
    @objc dynamic var photo100 = ""
    
    var fullname: String {
        firstName + " " + lastName
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
}
