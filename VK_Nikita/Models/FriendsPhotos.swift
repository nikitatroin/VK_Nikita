//
//  FriendsPhotos.swift
//  VK_Nikita
//
//  Created by Никита Троян on 02.11.2021.
//



import Foundation
import UIKit

// MARK: - Item
struct FriendPhotos: Codable {
    let sizes: [Size]
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

// MARK: - Size
struct Size: Codable {
    let url: String
    

}
