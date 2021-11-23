//
//  FirebaseIDModel.swift
//  VK_Nikita
//
//  Created by Никита Троян on 20.11.2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirebaseModel {
    let id: String
    var groups: [String]?
    let ref: DatabaseReference?
    
    init(id: String) {
        self.id = id
        self.ref = nil
        self.groups = nil
    }

    init(id: String, groups: [String]?) {
        self.id = id
        self.groups = groups
        self.ref = nil
    }
    
    init? (snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
              let id = value["id"] as? String,
              let groups = value["group"] as? [String] else {return nil}
        
        self.ref = snapshot.ref
        self.id = id
        self.groups = groups
        
    }
    
    func toAnyObject() -> [AnyHashable: Any] {
        return [
            "id": id,
            "group": [groups]
        ] as [AnyHashable: Any]
    }
    
}
