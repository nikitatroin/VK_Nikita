//
//  AVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 19.10.2021.
//

import UIKit
//подписалась на протокол делегата
class AVC: UIViewController, TVCDelegate {
    
    @IBOutlet weak var myLabel2: UILabel!
    
    @IBOutlet weak var myTextField: UITextField! {
        didSet {
            myTextField.delegate = self
        }
    }
    
    @IBOutlet weak var myLabel: UILabel!
    
    // при нажатие на кнопку создаём tableView controller, становимся его делегатом и переходим на него
    @IBAction func myButton(_ sender: Any) {
        let tvc = TVC()
        tvc.delegate = self
        self.navigationController?.pushViewController(tvc, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //реализовали требование протокола, передаём в текст букву
    func alphabetChosen(word: String) {
        self.myLabel.text = word
    }

 

}
//расширили наш класс,
extension AVC: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.myLabel2.text = textField.text
       
        
    }
    
}
