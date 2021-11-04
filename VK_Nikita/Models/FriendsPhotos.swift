//
//  FriendsPhotos.swift
//  VK_Nikita
//
//  Created by Никита Троян on 02.11.2021.
//
import UIKit
import RealmSwift

// MARK: - Item
class FriendPhotos: Codable {
    var sizes: [Size] = []

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

// MARK: - Size
class Size: Codable {
    var url = ""
    

}
