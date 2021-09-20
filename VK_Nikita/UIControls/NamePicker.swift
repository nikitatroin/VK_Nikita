//
//  namePicker.swift
//  VK_Nikita
//
//  Created by Никита Троян on 20.09.2021.
//

import UIKit

class NamePicker: UIControl {
    
    private var selectedLetter: Character? = nil {
        didSet {
            self.updateSelectedLetter()
            self.sendActions(for: .valueChanged)
        }
    }
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        self.setupView()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    
    private func setupView () {
        for letter in Names {
            let button = UIButton(type: .system)
            button.setTitle(String(letter.first!), for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.blue, for: .selected)
            button.addTarget(self, action: #selector(selectLetter(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        self.addSubview(stackView)
        
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .equalCentering
    }
    
    private func updateSelectedLetter() {
        for (index, button) in self.buttons.enumerated() {
            guard let letter = Names[index].first else { continue }
        button.isSelected = letter == self.selectedLetter
        }
    }

    
    @objc func selectLetter(_ sender:UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        guard let letter = Names[index].first else { return }
        self.selectedLetter = letter
    }
}
