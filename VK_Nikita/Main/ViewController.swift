//
//  ViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 05.09.2021.
//

import UIKit

@IBDesignable
class ViewController: UIViewController {


    
    @IBOutlet weak var Gradient: UIView!
    
    @IBOutlet private weak var login:UITextField!
    
    @IBOutlet private weak var password: UITextField!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBAction private func pressButton (_ sender:Any){
        loginCheck()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                      action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

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
        if let vc = vc as? TabBarViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        }
    }
    
        private func addGradient() {
            let layer = CAGradientLayer()
            layer.colors = [
                UIColor.blue.cgColor,
                UIColor.white.cgColor,
                UIColor.blue.cgColor,
            ]
            layer.locations = [
                0.3,
                0.5,
                0.8
            ]
            
            layer.startPoint = CGPoint.init(x: 0, y: 0)
            layer.endPoint = CGPoint.init(x: 0, y: 1)
            
            self.Gradient.layer.addSublayer(layer)
            layer.frame = self.Gradient.bounds
        }

}


