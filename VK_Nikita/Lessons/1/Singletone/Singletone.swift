//
//  Singletone.swift
//  VK_Nikita
//
//  Created by Никита Троян on 18.10.2021.
//

import UIKit

final class Singletone {
    // опциональная точка входа
    private static var privateShared: Singletone?
    //метод удаления
    class func shared () -> Singletone {
        //если privateShared не nil, то он становится экземпляром
        guard let unwrapShared = privateShared else
        { privateShared = Singletone()
            return privateShared!
        }
        //если nil, то unwrapShared становится singletone
        return unwrapShared
    }
    // метод удаления
    class func destroy () {
        privateShared = nil
    }
    
    var name = ""
    var money = 0
    
    private init () {
        print("init singletone")
    }
    deinit {
        print("deinit singletone")
    }
}
