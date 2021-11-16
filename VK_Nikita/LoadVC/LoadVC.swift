//
//  ViewController2.swift
//  VK_Nikita
//
//  Created by Никита Троян on 03.10.2021.
//

import UIKit

class LoadVC: UIViewController {
    
    @IBOutlet weak var circle_1: UIImageView!
    @IBOutlet weak var circle_2: UIImageView!
    @IBOutlet weak var circle_3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleAnimation1()
        circleAnimation2()
        circleAnimation3()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if let vc = R.Storyboard.Main.instantiateInitialViewController() {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
        

    }
    
    
    func circleAnimation1 () {
                let animationPath = #keyPath(CALayer.opacity)
                let interfal = CFTimeInterval(1)
                let animation = CABasicAnimation(keyPath: animationPath)
                animation.duration = interfal
                animation.fromValue = 0.8
                animation.toValue = 0
                animation.fillMode = CAMediaTimingFillMode.forwards
                animation.repeatCount = Float.infinity
                animation.isRemovedOnCompletion = true
                animation.beginTime = CACurrentMediaTime() + 0.2
                circle_1.layer.add(animation, forKey: nil)
        
    }
    
    func circleAnimation2 () {
                let animationPath = #keyPath(CALayer.opacity)
                let interfal = CFTimeInterval(1)
                let animation = CABasicAnimation(keyPath: animationPath)
                animation.duration = interfal
                animation.fromValue = 0.8
                animation.toValue = 0
                animation.fillMode = CAMediaTimingFillMode.forwards
                animation.repeatCount = Float.infinity
                animation.isRemovedOnCompletion = true
                animation.beginTime = CACurrentMediaTime() + 0.4
                circle_2.layer.add(animation, forKey: nil)
        
    }
    
    func circleAnimation3 () {
                let animationPath = #keyPath(CALayer.opacity)
                let interfal = CFTimeInterval(1)
                let animation = CABasicAnimation(keyPath: animationPath)
                animation.duration = interfal
                animation.fromValue = 0.8
                animation.toValue = 0
                animation.fillMode = CAMediaTimingFillMode.forwards
                animation.repeatCount = Float.infinity
                animation.isRemovedOnCompletion = true
                animation.beginTime = CACurrentMediaTime() + 0.6
                circle_3.layer.add(animation, forKey: nil)
        
    }

}
