//
//  RealmService.swift
//  VK_Nikita
//
//  Created by Никита Троян on 12.11.2021.
//

import UIKit
import RealmSwift

protocol RealmServiceProtocol {

    func save<T: Object>(_ item: [T])
    func read<T:Object>(_ type:T.Type) -> Results<T>
    func readArray<T:Object>(_ type: T.Type) -> Array<T>
    func deleteBy<T: Object>(name:String, type: T.Type)
    func updateValue<T:Object>(type:T.Type, property: String, oldValue: Any, newValue: Any)
}

class RealmServiceImpl: RealmServiceProtocol {
//    let config = Realm.Configuration(schemaVersion: 9)
//    lazy var mainRealm = try! Realm(configuration: config)
    // общая конфигурация для всех Realm'ов, которые мы будем доставать из методов ниже:
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 9)
    }
    
    // MARK: - Create
    func save<T: Object> (_ item: [T] ) {
        let mainRealm = try! Realm()
        do {
            try mainRealm.write {
                mainRealm.add(item)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Read
    func read<T:Object>(_ type: T.Type) -> Results<T> {
        let mainRealm = try! Realm()
        let models = mainRealm.objects(type)
        print(mainRealm.configuration.fileURL as Any)
        return models
    }
    
    func readArray<T:Object>(_ type: T.Type) -> Array<T> {
        let mainRealm = try! Realm()
        let models = mainRealm.objects(type)
        print(mainRealm.configuration.fileURL as Any)
        return Array(models)
    }
    
    
    // MARK: - Delete
    func deleteBy<T:Object>(name: String, type: T.Type) {
        let mainRealm = try! Realm()
        do {
            let models = mainRealm.objects(T.self)
            try mainRealm.write {
            guard let obj = models.filter("name == %@", name).first else { return }
            mainRealm.delete(obj)
            }
            print(Array(models))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Update
    func updateValue<T:Object>(type:T.Type, property: String, oldValue: Any, newValue: Any) {
        let mainRealm = try! Realm()
        guard let obj = read(type).filter("\(property) == %@", oldValue).first else { return }
        do {
            try mainRealm.write{
                obj.setValuesForKeys([property:newValue])
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateAndModifyBy(_ type:[FriendModel], id: Int) {
        let mainRealm = try! Realm()
        do {
            try mainRealm.write{
                print(mainRealm.configuration.fileURL as Any)
                mainRealm.add(type, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
