//
//  FirebaseService.swift
//  VK_Nikita
//
//  Created by Никита Троян on 20.11.2021.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol FirebaseServiceProtocol {
    func saveDataFor(_ id:String, andGroups:[String]?)
}

class FirebaseServiceImpl: FirebaseServiceProtocol {
    private var ref = Database.database().reference(withPath: "users")
    
    func saveDataFor(_ id:String, andGroups:[String]?) {
        if let andGroups = andGroups {
            let user = FirebaseModel(id: id, groups: andGroups)
            let usersContainerRef = self.ref.child("users")
            usersContainerRef.setValue(user.toAnyObject())
        }
        else {
            let user = FirebaseModel(id: id)
            let usersContainerRef = self.ref.child("users")
            usersContainerRef.setValue(user.toAnyObject())
        }
    }
}
