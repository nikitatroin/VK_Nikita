//
//  test.swift
//  VK_Nikita
//
//  Created by Никита Троян on 20.09.2021.
//

import UIKit

class test: UIImageView {
    
    @IBInspectable var radius: CGFloat = 20 {
        didSet {
            setNeedsDisplay()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addCorner()
    }
    
    private func addCorner () {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
