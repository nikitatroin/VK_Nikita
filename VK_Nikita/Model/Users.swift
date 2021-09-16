//
//  Users.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

struct Users {
    var name:String
    var lastname:String
    var avatar: UIImageView
    
    init(name:String, avatar:UIImageView, lastname:String) {
        self.avatar = avatar
        self.name = name
        self.lastname = lastname
    }
}

struct UsersAvatar {
    var avatar: UIImageView
    
}
