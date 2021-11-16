//
//  RealmService.swift
//  VK_Nikita
//
//  Created by Никита Троян on 12.11.2021.
//

import UIKit
import RealmSwift

// для сервисов принято создавать интерфейсы - протоколы, где будут объявлены основные функции

protocol RealmServiceProtocol {
    //расписываем все действия нашего сервиса, то есть C-R-U-D
    func create<T: Object>(_ item: T) -> Object
    func read<T:Object>(_ type:T.Type) -> Results<T>
    func readArray<T:Object>(_ type: T.Type) -> Array<T>
    func deleteBy<T: Object>(name:String, type: T.Type)
    func updateValue<T:Object>(type:T.Type, property: String, oldValue: Any, newValue: Any)
}

class RealmServiceImpl: RealmServiceProtocol {
    let config = Realm.Configuration(schemaVersion: 9)
    lazy var mainRealm = try! Realm(configuration: config)
    
    // MARK: - Create
    func create<T: Object> (_ item: T ) -> Object {
        do {
            try mainRealm.write {
                mainRealm.add(item)
            }
            return item
        } catch {
            print(error.localizedDescription)
        }
        return item
    }
    
    // MARK: - Read
    func read<T:Object>(_ type: T.Type) -> Results<T> {
        let models = mainRealm.objects(type)
        print(mainRealm.configuration.fileURL as Any)
        return models
    }
    
    func readArray<T:Object>(_ type: T.Type) -> Array<T> {
        let models = mainRealm.objects(type)
        print(mainRealm.configuration.fileURL as Any)
        return Array(models)
    }
    
    
    // MARK: - Delete
    func deleteBy<T:Object>(name: String, type: T.Type) {
        do {
            let models = mainRealm.objects(T.self)
            mainRealm.beginWrite()
            guard let obj = models.filter("name == %@", name).first else { return }
            mainRealm.delete(obj)
            try mainRealm.commitWrite()
            print(Array(models))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Update
    func updateValue<T:Object>(type:T.Type, property: String, oldValue: Any, newValue: Any) {
        guard let obj = read(type).filter("\(property) == %@", oldValue).first else { return }
        do {
            try mainRealm.write{
                obj.setValuesForKeys([property:newValue])
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateAndModifyBy (_ type:[FriendModel], id: Int) {
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
