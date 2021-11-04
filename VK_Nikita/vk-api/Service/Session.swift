//
//  Singeton.swift
//  VK_Nikita
//
//  Created by Никита Троян on 23.10.2021.
//

import UIKit
import SwiftKeychainWrapper

final class Session {
    
    private init () {}
    
    static let shared = Session()
    
    //а token, так как он требует безопасного хранения, будем храить в Keychain
    var token: String {
        set {
            KeychainWrapper.standard.set(newValue, forKey: "token")
        }
        get {
            KeychainWrapper.standard.string(forKey: "token") ?? ""
        }
    }
    
    // userId будем хранить в UserDefaults
    var userId: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
        get {
            UserDefaults.standard.string(forKey: "userId") ?? ""
        }
    }
    
    var expDate = Date(timeIntervalSince1970: TimeInterval(0.0))
    
    
}
