//
//  TestVC3.swift
//  VK_Nikita
//
//  Created by Никита Троян on 18.10.2021.
//

import UIKit
//создали некое событие
let changeColorNotification = Notification.Name("changeColor")

class TestVC3: UIViewController {
    
    var color = UIColor.blue

    override func viewDidLoad() {
        super.viewDidLoad()
        //подписываемся на событие, которое создали
        //default создаёт singleton, некая глобальная точка доступа для отправки событий
        //далее мы кидаем эти события ( пока что кидаем неизвестно кому)
        //можем от кого хотим отлавливать, от кого хотим получать 
        NotificationCenter.default.addObserver(self, selector: #selector(changeColor(notification:)), name: changeColorNotification, object: nil)
    
    }
// нажимая на кнопку мы вручную отсылаем себе notification на которую подписались
    @IBAction func recieveObserve (_ sender: Any) {
        let color: UIColor = .systemRed
        
        NotificationCenter.default.post(name: changeColorNotification, object: nil, userInfo: ["color":color])
    }
// в observe мы указали, что когда получим данную notification мы должны изменить цвет view
    @objc
    private func changeColor (notification:Notification) {
        guard let color = notification.userInfo?["color"] as? UIColor else { return }
        view.backgroundColor = color
    }
    
}
