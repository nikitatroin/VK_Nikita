//
//  test2.swift
//  VK_Nikita
//
//  Created by Никита Троян on 20.09.2021.
//

import UIKit
class test2: UIView {
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addShadow()
    }
    
    
    
    private func addShadow () {
        self.layer.cornerRadius = 16
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = .init(width: 2, height: 1)
    }

}

