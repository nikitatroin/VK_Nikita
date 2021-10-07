//
//  FriendsTableViewCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet  weak var name: UILabel!
    @IBOutlet  weak var avatar: UIImageView!
    

    func animate () {
        UIView.animate(withDuration: 0.2) {
            self.avatar.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.avatar.transform = .identity
            self.shadowView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.shadowView.transform = .identity
        }
    }
}
