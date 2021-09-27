//
//  FriendsTableViewCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var test2: test2!
    
    @IBOutlet  weak var name: UILabel!
    
    @IBOutlet  weak var lastname: UILabel!
    
    @IBOutlet  weak var avatar: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.name = nil
//        self.avatar = nil
//        self.lastname = nil
//        self.test2 = nil
//    }
    
    func configure (userInfo:Users) {
        self.name.text = userInfo.name
        self.lastname.text = userInfo.lastname
        self.avatar.image = userInfo.avatar
    }
    
}
