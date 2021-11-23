//
//  FirebaseGroupsModel.swift
//  VK_Nikita
//
//  Created by Никита Троян on 20.11.2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class GroupModel {
    let name: String
    let ref: DatabaseReference?
    
    init(name: String){
        self.name = name
        self.ref = nil
    }
    
    func toAnyObject() -> [AnyHashable: Any] {
        return [
            "name": name
        ] as [AnyHashable: Any]
    }
}
