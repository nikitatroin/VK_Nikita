//
//  TestVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 18.10.2021.
//

import UIKit

class TestVC: UIViewController {
    
    let singletone = Singletone.shared()

    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var moneyLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    @IBAction func sendMoney(_ sender: Any) {
        guard let moneyString = moneyLabel.text, let name = nameLabel.text, let money = Int(moneyString)
        else {return}
        singletone.money = money
        singletone.name = name
    }
    

}
