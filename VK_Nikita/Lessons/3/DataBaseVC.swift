//
//  DataBaseVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 04.11.2021.
//

import UIKit
import SwiftKeychainWrapper
import RealmSwift

// MARK: - Model
//создали класс для Realm
class User: Object {
    @objc dynamic var userId = ""
    @objc dynamic var token = ""
}

// MARK: - ViewController
class DataBaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //useUserDefault()
        //useKeychain()
        //useCoreData()
        //useRealm()
    }
// MARK: - UserDefault
    //незащищенное хранилище, можно добраться и считать из папки приложения, храним никому не нужные данные, такие как, допустим, прошёл ли пользователь tutorial или нет, также важно запомнить, что эти данные удаляются вместе с приложением, представляет собою словарь с ключ-значением
    func useUserDefault(){
        //создаём ключ
        UserDefaults.standard.integer(forKey: "stepForm")
        //создаём ключ
        UserDefaults.standard.bool(forKey: "isOnboarded")
        
        //сохраняем под ключами определённые значения
        UserDefaults.standard.set(3, forKey: "stepForm")
        UserDefaults.standard.set(true, forKey: "isOnboarded")
    }
    
// MARK: - KeyChain
    // хороший пример, если мы будем часто запрашивать token из vk api, то он может нас заблочить, поэтому его лучше хранить в keychain и обращаться по надобности, также требуется настроить время протухания tokena, чтобы автоматом запросить новый, когда это потребуется
    func useKeychain() {
        //используем библиотеку KeychainWrapper, она также как UserDefaults предоставляет точку доступа то есть Singletone
        
        
        //одновременно создали ключ и задали значение для нашего token'а, пустое значение
        KeychainWrapper.standard.set("", forKey: "token")
        
    }
    
// MARK: - CoreData
    func useCoreData() {
        //обращаемся к appDelegate, через Singleton, потом за downcasting'ли его в нужный нам класс AppDelegate, чтобы обратиться к нашему контейнеру
        
        // context это база данных, которая находится в оперативной памяти, через неё мы делаем запросы, она постоянно весит в памяти, также она может синхронизироваться с основной базой
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //первый шаг, загрузили объект в БД
        let newHuman = Human(context: context)
        newHuman.name = "Nikita"
        newHuman.gender = true
        newHuman.birthday = Date()
        // сохранили в оперативную память, также можно настроить, чтобы перед закрытием приложения context сохранялся
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        
        //второй шаг, выгружаем объект из БД
        do {
            let result = try context.fetch(Human.fetchRequest())
            
            if let human = result.first {
                print(human)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
// MARK: - Realm
    func useRealm() {
        let user = User()
        user.token = "12j3ej32oirj23r2jd2jod2j3"
        user.userId = "nikita"
        
        // сам класс Realm это и есть хранилище, создаём экземпляр
        do {
            // если мы налету изменим класс (объект, который сохраняли в Realm и попытаемся ещё раз записать его в БД, то мы получим ошибку, поэтому нужно прописать config для БД, чтобы она различала
            let migration = Realm.Configuration(schemaVersion: 1)
            let realm = try Realm(configuration: migration)
            //1-ый шаг
            //начинаем запись
            realm.beginWrite()
            // добавляем объект
            realm.add(user)
            // заканчиваем запись
            try realm.commitWrite()
            
            
            //2-ой шаг
            //считываем объект
            realm.objects(User.self).forEach({ print($0.token, $0.userId) })
            print(realm.configuration.fileURL ?? "")
            
        } catch  {
            print(error.localizedDescription)
        }
        
        
    }
    
}


