//
//  GroupsTableViewCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var avatar: UIImageView!
    
    func configure (_ userInfo:Groups) {
        self.avatar = userInfo.image
        self.name.text = userInfo.name
    }
    
}
