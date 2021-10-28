//
//  Friend1.swift
//  VK_Nikita
//
//  Created by Никита Троян on 28.10.2021.
//

import Foundation

// JSONSerialization
struct Friend1 {

    let id:Int

    let firstname:String?
    let lastname: String?
    let photo: String?
    

    init(item:[String:Any]) {
        self.id = item["id"] as! Int
        self.firstname = item["first_name"] as? String
        self.lastname = item["last_name"] as? String
        self.photo = item["photo_100"] as? String
    }
}
