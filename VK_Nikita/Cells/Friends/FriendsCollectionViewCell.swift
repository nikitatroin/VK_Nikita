//
//  FriendsCollectionViewCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    func configure (avatar:UIImageView) {
        self.avatar = avatar
    }
}
