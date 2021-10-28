//
//  Friend2.swift
//  VK_Nikita
//
//  Created by Никита Троян on 28.10.2021.
//

import Foundation
import SwiftyJSON

// SwiftyJSON
struct Friend2 {
    
    var id:Int
    // убрали опционал со свойств
    var firstname:String = ""
    var lastname: String = ""
    var photo: String = ""

    // инит теперь большой объект типа json, в котором будет хранится вся информация
    init(json:JSON) {
        self.id = json["id"].int!
        self.firstname = json["first_name"].string!
        self.lastname = json["last_name"].string!
        self.photo = json["photo_100"].string!
    }
    
}
