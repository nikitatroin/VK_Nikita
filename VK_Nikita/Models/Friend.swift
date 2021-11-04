//
//  Friend4.swift
//  VK_Nikita
//
//  Created by Никита Троян on 28.10.2021.
//

import Foundation
import RealmSwift

// MARK: - Item
class Friend4: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var lastName = ""
    @objc dynamic var firstName = ""
    @objc dynamic var photo100 = ""
    
    var fullname: String {
        firstName + " " + lastName
    }

    // CodingKey используется, когда имя в JSON не подходит нам для структуры, даже если мы меняем одно название в enum'е, то мы всё равно должны перечислить все наши имена, но не стоит забывать прописать String.
    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
}
