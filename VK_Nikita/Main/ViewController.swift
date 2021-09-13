//
//  ViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 05.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var login:UITextField!
    
    @IBOutlet private weak var password: UITextField!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBAction private func pressButton (_ sender:Any){
        loginCheck()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                      action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWasShow(notification:Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height + 150, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(notification:Notification){
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }
    
    @objc private func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    private func loginCheck () {
        let login = self.login.text!
        let password = self.password.text!
        if login == "admin" && password == "123" {

            showUserScene()
        } else {
            showAlertMSG()
        }
    }
    
    private func showAlertMSG(){
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Пароль или логин введены неверно",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ну понятно",
                                        style: .cancel)
        
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showUserScene(){
        let vc = R.Storyboard.Tabbar.instantiateInitialViewController()
        if let vc = vc as? TabbarViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        }
    }

}


