//
//  DataBaseVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 04.11.2021.
//

import UIKit
import SwiftKeychainWrapper

class DataBaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //useUserDefault()
        //useKeychain()
        useCoreData()
    }
    
    //незащищенное хранилище, можно добраться и считать из папки приложения, храним никому не нужные данные, такие как, допустим, прошёл ли пользователь tutorial или нет, также важно запомнить, что эти данные удаляются вместе с приложением, представляет собою словарь с ключ-значением
    func useUserDefault(){
        //создаём ключ
        let _ = UserDefaults.standard.integer(forKey: "stepForm")
        //создаём ключ
        let _ = UserDefaults.standard.bool(forKey: "isOnboarded")

        //сохраняем под ключами определённые значения
        UserDefaults.standard.set(3, forKey: "stepForm")
        UserDefaults.standard.set(true, forKey: "isOnboarded")
    }
    
    // хороший пример, если мы будем часто запрашивать token из vk api, то он может нас заблочить, поэтому его лучше хранить в keychain и обращаться по надобности, также требуется настроить время протухания tokena, чтобы автоматом запросить новый, когда это потребуется 
    func useKeychain() {
        //используем библиотеку KeychainWrapper, она также как UserDefaults предоставляет точку доступа то есть Singletone
        //создали ключ
        let _: String? = KeychainWrapper.standard.string(forKey: "token")
    
        //задали значение для нашего token'а, пустое значение
        KeychainWrapper.standard.set("", forKey: "token")
        
    }
    
    func useCoreData() {
        //обращаемся к appDelegate, через Singleton, потом за downcasting'ли его в нужный нам класс, чтобы обратиться к нашему контейнеру
        // context это база данных, которая находится в оперативной памяти, через неё мы делаем запросы, она постоянно весит в памяти, также она может синхронизироваться с основной базрй
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //первый шаг, загрузили объект в БД
        let newHuman = Human(context: context)
        newHuman.name = "Nikita"
        newHuman.gender = true
        newHuman.birthday = Date()
        
        
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
    
    func useRealm() {
        
    }
    
}


