//
//  ViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 05.09.2021.
//

import UIKit

@IBDesignable
class ViewController: UIViewController {


    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var Gradient: UIView!
    
    @IBOutlet private weak var login:UITextField!
    
    @IBOutlet private weak var password: UITextField!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBAction private func pressButton (_ sender:Any){
        loginCheck()
    }
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLoginButton()
        animateLabelAppearing()
        animateLogoAppearing()
        animateFieldAppearing()
        addGradient()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        self.tabBarController?.viewControllers = []
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
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height + 150, right: 0.0)
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
            shafleAnimation()
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
    
    private func animateFieldAppearing () {
        let offset = self.view.bounds.width
        login.transform = CGAffineTransform(translationX: -offset, y: 0)
        password.transform = CGAffineTransform(translationX: offset, y: 0)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: {
            self.login.transform = .identity
            self.password.transform = .identity
        },
                       completion: nil)
        
        
    }
    
    private func animateLogoAppearing () {
        let offset = self.view.bounds.height/2
        logo.transform = CGAffineTransform(translationX: 0, y: -offset)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
            self.logo.transform = .identity
        },
                       completion: nil)
        
        
    }
    
    private func animateLabelAppearing () {
        let animationKeyPath = "opacity"
        let animation = CABasicAnimation(keyPath: animationKeyPath)
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        animation.beginTime = CACurrentMediaTime() + 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        self.loginLabel.layer.add(animation, forKey: nil)
        self.passwordLabel.layer.add(animation, forKey: nil)
        
    }
    
    private func animateLoginButton () {
        self.button.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: {
            self.button.transform = .identity
        },
                       completion: nil)
        
    }
    
    func shafleAnimation () {
        let animationPath = "transform.translation.x"
        let shakeAnimation = "shake"
        let duration = 0.5
        let animation = CAKeyframeAnimation(keyPath: animationPath)
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        button.layer.add(animation, forKey: shakeAnimation)
    }

}


