//
//  FriendsCollectionViewCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    private var a = 0

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var heart: UIImageView! 
       
    @IBOutlet weak var heartCount: UILabel!
    
    @IBOutlet weak var control1: UIControl!
    
    @IBAction func control(_ sender: Any) {
        self.heart.image = UIImage(systemName: "heart.fill")
        a += 1
        if self.control1.isHighlighted == true {
            control1.isHighlighted.toggle()
            heartCount.text = "\(a)"
        }
        
    }
    
    func configure (avatar:UIImage) {
        self.avatar.image = avatar
    }
    

}
