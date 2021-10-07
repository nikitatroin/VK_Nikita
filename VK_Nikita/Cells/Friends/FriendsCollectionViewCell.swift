//
//  FriendsCollectionViewCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var avatar: UIImageView! {
        didSet {
            avatar.clipsToBounds = true
            avatar.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var shadowView: UIView! {
        didSet {
            self.shadowView.layer.shadowOffset = .zero
            self.shadowView.layer.shadowOpacity = 0.2
            self.shadowView.layer.shadowRadius = 6
            self.shadowView.backgroundColor = .clear
            self.shadowView.layer.masksToBounds = false
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.shadowView.layer.shadowPath = UIBezierPath(rect: avatar.frame).cgPath
        self.avatar.layer.cornerRadius = 30
            
    }

}
