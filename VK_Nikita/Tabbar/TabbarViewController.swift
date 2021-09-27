//
//  TabBarViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 14.09.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers![0].tabBarItem.title = "Friends"
        self.viewControllers![0].tabBarItem.image = UIImage(systemName: "person.fill")
        self.viewControllers![1].tabBarItem.title = "Groups"
        self.viewControllers![1].tabBarItem.image = UIImage(systemName: "person.3.fill")
    }
    


}
