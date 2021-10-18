//
//  TestVC2.swift
//  VK_Nikita
//
//  Created by Никита Троян on 18.10.2021.
//

import UIKit

class TestVC2: UIViewController {
    
    let singletone = Singletone.shared()

    @IBOutlet weak var moneyLabel: UILabel! {
        didSet {
            moneyLabel.text = String(singletone.money)
        }
    }
    
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = singletone.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
