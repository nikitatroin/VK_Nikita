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
    
    func configure () {
        self.avatar.contentMode = .scaleAspectFill
        self.avatar.layer.masksToBounds = true
        self.avatar.layer.cornerRadius = 8
        self.shadowView.backgroundColor = .clear
        self.shadowView.layer.masksToBounds = false
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowRadius = 1.5
        self.shadowView.layer.shadowOpacity = 0.5
        self.shadowView.layer.shadowOffset = .init(width: -5, height: 5)
        let radius = self.avatar.layer.cornerRadius
        self.shadowView.layer.shadowPath = UIBezierPath(roundedRect: self.avatar.bounds, cornerRadius: radius).cgPath
    }
    

    func animate () {
        UIView.animate(withDuration: 0.2) {
            self.avatar.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.avatar.transform = .identity
            self.shadowView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.shadowView.transform = .identity
        }
    }
}
