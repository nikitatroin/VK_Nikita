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
    
    let friendsList = [
            User(userName: "Коля",
                 userAvatar: (UIImage(named: "1")!),
                 userPhotos: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!,
                              UIImage(named: "4")!, UIImage(named: "5")!]),
            
            User(userName: "Ваня",
                 userAvatar: (UIImage(named: "2")!),
                 userPhotos: [UIImage(named: "5")!, UIImage(named: "3")!, UIImage(named: "2")!]),
            
            User(userName: "Василий",
                 userAvatar: (UIImage(named: "3")!),
                 userPhotos: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "4")!]),
            
            User(userName: "Анжелика",
                 userAvatar: (UIImage(named: "4")!),
                 userPhotos: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!]),
            
            User(userName: "Николай",
                 userAvatar: (UIImage(named: "5")!),
                 userPhotos: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "5")!]),
            
            User(userName: "Аня",
                 userAvatar: (UIImage(named: "2")!),
                 userPhotos: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "5")!]),
            
            User(userName: "Иван",
                 userAvatar: (UIImage(named: "5")!),
                 userPhotos: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!]),
            
            User(userName: "Ксения",
                 userAvatar: (UIImage(named: "3")!),
                 userPhotos: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "4")!,
                              UIImage(named: "5")!]),
            
            User(userName: "Анна",
                 userAvatar: (UIImage(named: "4")!),
                 userPhotos: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "4")!,
                              UIImage(named: "3")!, UIImage(named: "5")!])
        ]
    
    var letterAndNameList: [String:[String:UIImage]] = [:]
    var alphabetNameLetters: [String] = []
    
    var searchArr: [String] = []
    var findedArr: [String] = []
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(R.Cell.friendTableCell, forCellReuseIdentifier: R.Identifier.friendTableCell)
        self.searchBar.delegate = self
        lettersAndName ()
        onlyLatters ()
        searchingArr ()
        findingArr ()
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(FriendViewController.handleLongPress))
        lpgr.minimumPressDuration = 1
        tableView.addGestureRecognizer(lpgr)
        
    }
    

    private func lettersAndName (){
        friendsList.forEach {
            guard let letter = $0.userName.first else {return}
            if letterAndNameList[String(letter)] == nil {
                letterAndNameList[String(letter)] = [$0.userName: $0.userAvatar]
            } else {
                letterAndNameList.updateValue([$0.userName: $0.userAvatar], forKey: String(letter))
            }
        }
    }
    
    private func onlyLatters (){
        friendsList.forEach {
            alphabetNameLetters.append(String($0.userName.first!))
        }
        let set = Set(alphabetNameLetters)
        alphabetNameLetters = Array(set)
        alphabetNameLetters = alphabetNameLetters.sorted(by: <)
    }
    
    private func searchingArr (){
        friendsList.forEach {
            searchArr.append($0.userName)
        }
        searchArr = searchArr.sorted(by: <)
    }
    
    
    private func findingArr (){
        friendsList.forEach {
            findedArr.append($0.userName)
        }
    }
    
    internal func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.searchBar.resignFirstResponder()
        self.searchArr.removeAll()
        return true
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchBar.text?.count != 0 {
            searchArr.removeAll()
            for str in findedArr {
                let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    self.searchArr.append(str)
                }
            }
        }
    tableView.reloadData()
    return true
    }
    // action для нажатия
    @objc func handleLongPress (_ gesture:UILongPressGestureRecognizer) {
        // если нажатие уже началось
        if gesture.state != .began {
            // если палец на tableView
            let tapLocation = gesture.location(in: self.tableView)
            // если палец на ячейки
            if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
                // если это та самая ячейка
                if let tappedCell = self.tableView.cellForRow(at: tapIndexPath) as? FriendsTableViewCell {
                    //выполняем анимацию
                    tappedCell.animate()
                }
            }
        }
        
    }
    

}

extension FriendViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchBar.text?.isEmpty == false {
            return 1
        }
        return alphabetNameLetters.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text?.isEmpty == false {
            return searchArr.count
        }
        let letterKey = alphabetNameLetters[section]
            if let elementsInSection = letterAndNameList[letterKey] {
                return elementsInSection.count
            } else {
                return 0
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.Identifier.friendTableCell, for: indexPath) as? FriendsTableViewCell {
            if searchBar.text?.isEmpty != true {
                cell.name.text = searchArr[indexPath.row]
                cell.avatar.image = UIImage()
                return cell
            } else {
                let letterKey = alphabetNameLetters[indexPath.section]
                    if let dictValue = letterAndNameList[letterKey] {
                        let lazyMapCollection = dictValue.keys
                        let keysString = Array(lazyMapCollection.map { String($0) }).sorted(by: <)
                        cell.name.text = keysString[indexPath.row]
                        cell.avatar.image = dictValue[keysString[indexPath.row]]
                    }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchBar.text?.isEmpty == false {
            return "Found matches \(searchArr.count)"
        }
        return String(alphabetNameLetters[section])
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var indexTitleList = [String]()
        for element in alphabetNameLetters {
            indexTitleList.append(String(element))
        }
        return indexTitleList
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = alphabetNameLetters.firstIndex(of: title) else { return -1 }
        return index
    }
    
}

extension FriendViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "friendCollectionVC") as? FriendCollectionViewController
        let letterKey = alphabetNameLetters[indexPath.section]
            if let dictValue = letterAndNameList[letterKey] {
                let lazyMapCollection = dictValue.keys
                let keysString = Array(lazyMapCollection.map { String($0) }).sorted(by: <)
                vc?.avatar = dictValue[keysString[indexPath.row]]!
        self.navigationController?.pushViewController(vc!, animated: true)
            }
    }
    
}

