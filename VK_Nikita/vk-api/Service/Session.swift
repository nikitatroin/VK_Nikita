//
//  Singeton.swift
//  VK_Nikita
//
//  Created by Никита Троян on 23.10.2021.
//

import UIKit

final class Session {
    
    private init () {}
    
    static let shared = Session()
    
    var token = ""
    var userId = ""
    
    
}
