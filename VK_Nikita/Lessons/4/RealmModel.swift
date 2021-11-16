//
//  RealmModel.swift
//  VK_Nikita
//
//  Created by Никита Троян on 12.11.2021.
//

import UIKit
import RealmSwift

@objcMembers
final class PersonModel: Object {
    var id: Int = 0
    var name: String = ""
    var age: Int = 0
    
    convenience init(name:String, age: Int, id: Int) {
        self.init()
        self.name = name
        self.age = age
        self.id = id
    }
    // массив моих pets
    let pets = List<PetModel>()
    
    override class func primaryKey() -> String? {
        "id"
    }
}

@objcMembers
final class PetModel: Object {
    var name: String = ""
    var owner: PersonModel?
    
    //добавили ссылку на главную модель, которая держит массив
    let owners = LinkingObjects(fromType: PersonModel.self, property: "pets")
    
    convenience init(name:String, owner: PersonModel) {
        self.init()
        self.name = name
        self.owner = owner
    }
    
    
}
