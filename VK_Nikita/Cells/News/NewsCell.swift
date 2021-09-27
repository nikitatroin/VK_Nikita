//
//  NewsCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 27.09.2021.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView (){
        self.backgroundColor = UIColor.white
        self.addSubview(nameLabel)
        self.addSubview(profileImageView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-[v1]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0) , metrics: nil,
                                                      views: ["v0":profileImageView,
                                                              "v1":nameLabel,]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["v0":nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["v0":profileImageView]))
        
//        let views = ["v0": nameLabel]
//            let widthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
//            let heightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
//            let horizontalConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: -135)
//            let verticalConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
//
//            self.addConstraints(widthConstraints)
//            self.addConstraints(heightConstraints)
//            self.addConstraints([horizontalConstraint, verticalConstraint])
//
        
    }
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
                      
    
    let nameLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Sample Name"
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
}