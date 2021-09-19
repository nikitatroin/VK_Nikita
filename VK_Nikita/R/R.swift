//
//  R.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

enum R {
    enum Storyboard {
        static let Main:UIStoryboard = .init(name: "Main", bundle: nil)
        static let Tabbar:UIStoryboard = .init(name: "Tabbar", bundle: nil)
        static let Friends:UIStoryboard = .init(name: "Friends", bundle: nil)
        static let Groups:UIStoryboard = .init(name: "Groups", bundle: nil)
    }
    
    enum Cell {
        static let friendTableCell:UINib = .init(nibName: "FriendsTableViewCell", bundle: nil)
        static let friendCollectionCell:UINib = .init(nibName: "FriendsCollectionViewCell", bundle: nil)
        static let groupTableCell:UINib = .init(nibName: "GroupsTableViewCell", bundle: nil)
    }
    
    enum Identifier {
        static let friendTableCell:String = .init("friendTableCell")
        static let groupsTableCell:String = .init("groupsTableCell")
        static let friendCollectionCell:String = .init("collectionViewCell")
    }
}
