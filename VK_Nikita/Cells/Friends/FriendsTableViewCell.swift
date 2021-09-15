//
//  FriendsTableViewCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var name: UILabel!
    
    @IBOutlet private weak var lastname: UILabel!
    
    @IBOutlet private weak var avatar: UIImageView!
    
    func configure (userInfo:Users) {
        self.name.text = userInfo.name
        self.lastname.text = userInfo.lastname
        self.avatar = userInfo.avatar
    }
    
}
