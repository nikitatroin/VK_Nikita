//
//  NewsCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 27.09.2021.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView (){
        self.backgroundColor = UIColor.white
        self.addSubview(nameLabel)
        self.addSubview(profileImageView)
        
        addConstWithFormat(format: "H:|-8-[v0(44)]-8-[v1]", views: profileImageView, nameLabel)
        addConstWithFormat(format: "V:|-8-[v0]", views: nameLabel)
        addConstWithFormat(format: "V:|-8-[v0(44)]", views: profileImageView)
        

    }
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Я")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
                      
    
    let nameLabel: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "Nikita Troyan",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15)])
        
        attributedText.append(NSAttributedString(string: "\n· September 28 · Saint Petersburg ·", attributes:
                                                    [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 13),
                                                    NSAttributedString.Key.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
        
        lable.attributedText = attributedText
        
        return lable
    }()
    
}

extension UIView {
    // создаём расширение для UIView, добавляем функцию, в ней первый элемент это VisualFormat, второе это массив всех View
    func addConstWithFormat(format: String, views: UIView...) {
        //далее создаётся словарь, где VisualFormat приклеплён к определённой View
        var viewDict = [String:UIView]()
        //далее берём массив всех полученных View, перебераем View и её index
        for (index, view) in views.enumerated() {
            //индекс используем как число после v
            let key = "v\(index)"
            //а под этим key, будет хранится одна из view нашего массива из общих view
            viewDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
            //когда данное свойство у view включено мы можем модифицировать только frame, bounds and center свойство, а xcode в зависимости от этого задаёт расположение для view.
            //когда мы из кода задаём constraints, мы ограничиваем view в пространстве superView и она занимает размер в соответствии с этими правилами
            //
        }
        // добавили constaint, в который будет передаваться наш VisualFormat и наш словарь, которых хранит VisualFormat и view
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: viewDict))
    }
}
//то есть есть один массив из всех view на superView, есть словарь, которых хранит VisualFormat типа "v0" или "v1", как ключ и значение, то есть саму view, которую требуется установить
