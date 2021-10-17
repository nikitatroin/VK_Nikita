//
//  ViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 05.09.2021.
//

import UIKit

@IBDesignable
class ViewController: UIViewController {

    // MARK: - Outlets
    
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

    // MARK: - Properties
    var animator: UIViewPropertyAnimator!
    
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLoginButton()
        animateLabelAppearing()
        animateLogoAppearing()
        animateFieldAppearing()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard))
        let panLoginButton = UIPanGestureRecognizer(target: self,
                                                    action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(panLoginButton)
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
    
    // MARK: - Methods
    
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
    
    @objc private func onPan (_ gesture:UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.animator = .init(duration: 5, curve: .linear, animations: {
                self.button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
            self.animator.startAnimation()
        case .changed:
            let translation = gesture.translation(in: self.view)
            self.button.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeCubicPaced) {
                self.button.transform = .identity
            }
        default:
            return
        }
    }
    
    // MARK: - Alert
    private func showAlertMSG(){
        let alertController = UIAlertController(title: "Ошибка",
                                                message:
                                                    "Пароль или логин введены неверно",
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
    // MARK: - Gradient
    
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
    
    // MARK: - Animation
    private func animateFieldAppearing () {
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 0
        fadeAnimation.fromValue = 1
        
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.fromValue = 0
        springAnimation.toValue = 1
        springAnimation.stiffness = 150
        springAnimation.mass = 2
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1
        animationGroup.timeOffset = 1
        animationGroup.beginTime = CACurrentMediaTime() + 1.5
        animationGroup.fillMode = .both
        animationGroup.timingFunction = .init(name: .default)
        animationGroup.animations = [fadeAnimation,springAnimation]
        self.login.layer.add(animationGroup, forKey: nil)
        self.password.layer.add(animationGroup, forKey: nil)
    }
    
    private func animateLogoAppearing () {
        let offset = self.view.bounds.height/2
        logo.transform = CGAffineTransform(translationX: 0, y: -offset)
        
        let animator = UIViewPropertyAnimator(duration: 1,
                                              dampingRatio: 0.7) {
        self.logo.transform = .identity
        }
        animator.startAnimation(afterDelay: 1)
        
    }
    
    private func animateLabelAppearing () {
        // abs это чистое число без минуса, так как результат вычитание будет отрицательным
        //midY это центр по y каждого из наших элементов
        UIView.animate(withDuration: 0) {
            let offset = abs(self.loginLabel.frame.midY -
                             self.passwordLabel.frame.midY)
            self.loginLabel.transform = CGAffineTransform(translationX: 0, y: offset)
            self.passwordLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
        }

        UIView.animateKeyframes(withDuration: 1,
                                delay: 1,
                                options: .calculationModeCubicPaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.5) {
                self.loginLabel.transform = CGAffineTransform(translationX: 150, y: 50)
                self.passwordLabel.transform = CGAffineTransform(translationX: -150, y: 50)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5,
                               relativeDuration: 0.5) {
                self.loginLabel.transform = .identity
                self.passwordLabel.transform = .identity
            }
        },
                                completion: nil)
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


