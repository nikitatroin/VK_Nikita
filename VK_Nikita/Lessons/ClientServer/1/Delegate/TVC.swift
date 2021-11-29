//
//  TVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 19.10.2021.
//

import UIKit

//создали протокол-объект, его требования выполнять метод
protocol TVCDelegate: AnyObject {
    
    func alphabetChosen(word:String)
    
}

class TVC: UITableViewController {
    // у нас есть tableView, внутри которого есть слабая ссылка на этот протокол, то есть у источника, который будет передавать данные есть ссылка на объект протокола, а сам делегат conform этому делегату
    weak var delegate: TVCDelegate?
    // есть массив букв
    var alphabet = ["А","Б","В","Г","Д"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Сell")
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alphabet.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Сell", for: indexPath)
        cell.textLabel?.text = alphabet[indexPath.row]
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //мы получаем букву по нажатию на неё в таблице
        let alphabet = alphabet[indexPath.row]
        //передаём в делегат эту букву
        delegate?.alphabetChosen(word: alphabet)
        //затем переносимся на контроллер назад
        self.navigationController?.popViewController(animated: true)
    }

}
