//
//  FirendViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction func logout(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController") as? ViewController
        vc!.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    var displayItem: [Users] = [
                            Users(name: "Nikita",lastname: "Troyan",avatar: UIImage(named: "Я")!),
                            Users(name: "Nikolai",lastname: "Ivanov",avatar: UIImage(named: "1")!),
                            Users(name: "Daria",lastname: "Belikova",avatar: UIImage(named: "2")!),
                            Users(name: "Kristina",lastname: "Tarasova",avatar: UIImage(named:"3")!)
                            ]
    
    
    var dict: [Character:[String]] = [:]
    var dict2:[Character] = []
    var dict3:[String] = []
    var searchedArr:[String] = Array()
    
    
    
    private var userPhotos: [UsersAvatar] = [
        .init(avatar: UIImage(imageLiteralResourceName: "Я"))
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.register(R.Cell.friendTableCell, forCellReuseIdentifier: R.Identifier.friendTableCell)
        self.searchBar.delegate = self
        createDict()
        createDict2()
        createDict3()
        searchArr()
        
    }
    
    private func createDict (){
        displayItem.forEach {
            guard let letter = $0.name.first else {return}
            if dict[letter] == nil {
                dict[letter] = [$0.name]
            } else {
                dict[letter]?.append($0.name)
            }
        }
    }
    
    private func createDict2 (){
        displayItem.forEach {
            dict2.append($0.name.first!)
        }
        dict2 = dict2.sorted(by: <)
    }
    
    private func createDict3 (){
        displayItem.forEach {
            dict3.append($0.name)
        }
        dict3 = dict3.sorted(by: <)
    }
    
    
    private func searchArr (){
        displayItem.forEach {
            searchedArr.append($0.name)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.searchBar.resignFirstResponder()
        self.searchedArr.removeAll()
        searchArr()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchBar.text?.count != 0 {
            searchedArr.removeAll()
            for str in dict3 {
                let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    self.searchedArr.append(str)
                }
            }
        }
    tableView.reloadData()
    return true
    }
    

}

extension FriendViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchBar.text?.isEmpty == false {
            return 1
        }
        return dict.keys.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text?.isEmpty == false {
            return searchedArr.count
        }
        return dict[dict2[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: R.Identifier.friendTableCell, for: indexPath) as! FriendsTableViewCell
    
        if searchBar.text?.isEmpty != true {
            cell.name.text = searchedArr[indexPath.row]
        } else {
            let letterKey = dict2[indexPath.section]
            if let dictValue = dict[letterKey] {
                
            cell.name.text = dictValue[indexPath.row]
            }
        
//        cell.lastname.text = dictValue[indexPath.row].lastname
//        cell.avatar = dictValue[indexPath.row].avatar
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchBar.text?.isEmpty == false {
            return "Found matches \(searchedArr.count)"
        }
        return String(dict2[section])
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var indexTitleList = [String]()
        for element in Set(dict2) {
            indexTitleList.append(String(element))
        }
        return indexTitleList
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = dict2.firstIndex(of: Character(title)) else { return -1 }
        return index
    }
    
}

extension FriendViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        (cell as? FriendsTableViewCell)?.configure(userInfo: displayItem[indexPath.row])
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "friendCollectionVC") as? FriendCollectionViewController
        vc?.avatar = displayItem[indexPath.row].avatar
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}

