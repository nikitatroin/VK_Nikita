//
//  NewsCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 27.09.2021.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    let newsService = NewsApi()
    var response:[NewsItem] = []
    
    //если кастомизируем собственную View(в том числе и cell, настройки производим в init)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        newsService.getNews { response in
            if let response = response {
            self.response = response
            self.statusTextView.text = self.response[0].text
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView (){
        self.backgroundColor = UIColor.white
        self.addSubview(nameLabel)
        self.addSubview(profileImageView)
        self.addSubview(statusTextView)
        self.addSubview(statusImageView)
        self.addSubview(likeCommentLabel)
        self.addSubview(dividerLineView)
        self.addSubview(likeButton)
        self.addSubview(commentButton)
        self.addSubview(shareButton)
        
        
        addConstWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton,commentButton,shareButton)
        
        addConstWithFormat(format: "H:|-10-[v0]-10-|", views: dividerLineView)
        addConstWithFormat(format: "H:|-8-[v0]-2-|", views: likeCommentLabel)
        addConstWithFormat(format: "H:|-8-[v0]-8-|", views: statusImageView)
        addConstWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        // выставили Visual Format constraint, первый по горизонтале, где показаны profileImage и label
        addConstWithFormat(format: "H:|-8-[v0(44)]-8-[v1]", views: profileImageView, nameLabel)
        // а по вертикале, то есть как они относятся к верхней части view
        addConstWithFormat(format: "V:|-8-[v0]", views: nameLabel)
        //заметим, что в круглых скобках задали значение 44 по горизонтале и 44 по вертикале, тем самым задали ширину и высоту для нашего image
        addConstWithFormat(format: "V:|-8-[v0(44)]-8-[v1(60)]-8-[v2]-10-[v3(40)]-2-[v4(0.4)][v5(30)]|", views: profileImageView,statusTextView,statusImageView,likeCommentLabel,dividerLineView,likeButton)
        
        addConstWithFormat(format: "V:[v0(30)]|", views: commentButton)
        addConstWithFormat(format: "V:[v0(30)]|", views: shareButton)
        

    }
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.font = UIFont.systemFont(ofSize: 14)
        
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "SPB"))
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    let likeCommentLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.text = "Likes 246 \nComments 38"
        label.textColor = UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 226/255, green: 228/255, blue: 232/255, alpha: 1)
        return view
    }()
    
    
    //создали image из closure
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Я")
        // растянули, чтобы он встал как надо
        imageView.contentMode = .scaleAspectFit
        // так как мы задаём constraints из кода, нам нужно в ручную выключить автоматическое выставление constraints, но если задаём constraints из кода(через interface builder), это свойство по умолчанию false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
                      
    
    let nameLabel: UILabel = {
        //создали Label с двумя линиями
        let lable = UILabel()
        lable.numberOfLines = 2
        // сконфигурировали первую линию
        let attributedText = NSMutableAttributedString(string: "Nikita Troyan",attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15)])
        // сконфигурировали вторую линию, заметим, что настройка происходит через attribute key (который включает параметры label и значение, которое мы хотим задать
        attributedText.append(NSAttributedString(string: "\n· September 28 · Saint Petersburg ·", attributes:
                                                    [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 13),
                                                    NSAttributedString.Key.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "globe")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        
        attributedText.append(NSAttributedString(attachment:attachment))
        lable.attributedText = attributedText
        
        return lable
    }()
    
    //создание кнопок
    let likeButton = NewsCell.setButton(title: "Like", view: "hand.thumbsup")
    let commentButton = NewsCell.setButton(title: "Comment", view: "message")
    let shareButton = NewsCell.setButton(title: "Share", view: "arrowshape.turn.up.forward")
    
    //кнопка по умолчанию
    static func setButton (title:String, view:String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 163/255, alpha: 1), for: .normal)
        button.setImage(UIImage(systemName: view), for: .normal)
        //button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }
    
}
// расширение для Visual Format
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
        // добавили constaint, в который будет передаваться наш VisualFormat и наш словарь, который хранит VisualFormat и view
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: viewDict))
    }
}
//то есть есть один массив из всех view на superView, есть словарь, которых хранит VisualFormat типа "v0" или "v1", как ключ и значение
