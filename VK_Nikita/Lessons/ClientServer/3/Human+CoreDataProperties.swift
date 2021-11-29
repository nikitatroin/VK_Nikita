//
//  Human+CoreDataProperties.swift
//  VK_Nikita
//
//  Created by Никита Троян on 04.11.2021.
//
//

import Foundation
import CoreData


extension Human {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Human> {
        return NSFetchRequest<Human>(entityName: "Human")
    }

    @NSManaged public var birthday: Date?
    @NSManaged public var gender: Bool
    @NSManaged public var name: String?

}

extension Human : Identifiable {

}
