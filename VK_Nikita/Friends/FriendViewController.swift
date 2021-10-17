//
//  FirendViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction func logout(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController") as? ViewController
        vc!.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
// MARK: Data
    let friendsList = [
            User(userName: "Коля",
                 userAvatar: (UIImage(named: "1")!),
                 userPhotos: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!,
                              UIImage(named: "4")!, UIImage(named: "5")!]),
            
            User(userName: "Ваня",
                 userAvatar: (UIImage(named: "Я")!),
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
                 userAvatar: (UIImage(named: "Я")!),
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
    
    
    var nameList: [String] = []
    var lettersList: [String] = []
    var searchArr: [String] = []
    var findedArr: [String] = []
    

    
// MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(R.Cell.friendTableCell, forCellReuseIdentifier: R.Identifier.friendTableCell)
        self.searchBar.delegate = self
        makeNamesList()
        makeLettersList()
        searchingArr ()
        findingArr ()
       
    }
    
// MARK: Make arrs
    
    private func makeNamesList (){
        friendsList.forEach {
            nameList.append($0.userName)
            nameList = nameList.sorted(by: <)
        }
    }
    
    private func makeLettersList(){
        friendsList.forEach {
            lettersList.append(String($0.userName.first!))
            let letersSet = Set(lettersList)
            lettersList = Array(letersSet)
            lettersList = lettersList.sorted(by: <)
        }
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
            findedArr = findedArr.sorted(by: <)
        }
    }
    
// MARK: Get info for cells
    
    private func getNameForCell (_ indexPath: IndexPath) -> String {
        //создаём пустой массив имён, которые будут содержаться в секции
        var namesOfRows = [String]()
        nameList.forEach {
            //проходимся по всем именем в массиве имён
            if lettersList[indexPath.section].contains($0.first!) {
                //если имя содержит букву, которая указанна в определённой секции и буква имени совпадают, то добавляем это имя в массив
                namesOfRows.append($0)
            }
        }
        return namesOfRows[indexPath.row]
    }
    
    private func getUserAvatarForCell (_ indexPath: IndexPath) -> UIImage? {
        for friend in friendsList {
            let namesRows = getNameForCell(indexPath)
            if friend.userName.contains(namesRows) {
                return friend.userAvatar
            }
        }
        return nil
    }
    
    
    private func getPhotosFriend (_ indexPath: IndexPath) -> [UIImage?] {
        var photos: [UIImage?] = []
        for friend in friendsList{
        let namesRows = getNameForCell(indexPath)
            if friend.userName.contains(namesRows) {
                photos.append(contentsOf: friend.userPhotos)
            }
        }
        return photos
    }
    
// MARK: Configure search
    
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
    
// MARK: Handle gesture
    
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
// MARK: UITableViewDataSource

extension FriendViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchBar.text?.isEmpty == false {
            return 1
        }
        return lettersList.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countOfRow = 0
        if searchBar.text?.isEmpty == false {
            return searchArr.count
        } else {
            nameList.forEach {
                //обращаемся к массиву с буквами и проверяем
                if lettersList[section].contains($0.first!) {
                    countOfRow += 1
                }
            }
            return countOfRow
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.Identifier.friendTableCell, for: indexPath) as? FriendsTableViewCell {
            if searchBar.text?.isEmpty != true {
                cell.name.text = searchArr[indexPath.row]
                cell.avatar.image = getUserAvatarForCell(indexPath)
                return cell
            } else {
                let lpgr = UITapGestureRecognizer(target: self, action: #selector(FriendViewController.handleLongPress))
                cell.avatar.isUserInteractionEnabled = true
                cell.avatar.addGestureRecognizer(lpgr)
                cell.shadowView.isUserInteractionEnabled = true
                cell.name.text = getNameForCell(indexPath)
                cell.avatar.image = getUserAvatarForCell(indexPath)
                    }
                return cell
            }
        return UITableViewCell()
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = GradientView()
        let label = UILabel(frame: CGRect(x: 8, y: 5, width: 20, height: 20))
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.text = lettersList[section]
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.heavy)
        header.startColor = .white
        header.endColor = .blue
        header.startPoint = .init(x: 1 , y: 0)
        header.endPoint = .init(x: 0 , y: 1)
        header.startLocation = 0
        header.endLocation = 1
        header.addSubview(label)
        
        return header
    }
    
    // настройка высоты header для секций
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    // настройка title на header в каждой секции
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if searchBar.text?.isEmpty == false {
//            return "Founded matches \(searchArr.count)"
//        }
//        return lettersList[section]
//    }
    
//    // боковая панель с буквами
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        var indexTitleList = [String]()
//        for element in lettersList {
//            indexTitleList.append(element)
//        }
//        return indexTitleList
//    }
//    // переносит нас к букве секции
//    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        guard let index = lettersList.firstIndex(of: title) else { return -1 }
//        return index
//    }
    
    
}
// MARK: UITableViewDelegate

    extension FriendViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let vc = storyboard?.instantiateViewController(withIdentifier: "friendCollectionVC") as? FriendCollectionViewController
                    vc?.avatar = getPhotosFriend(indexPath)
                    self.navigationController?.pushViewController(vc!, animated: true)
            
                }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let view = (cell as? FriendsTableViewCell)!.avatar
            let shadow = (cell as? FriendsTableViewCell)!.shadowView
            view?.contentMode = .scaleAspectFill
            view?.layer.masksToBounds = true
            view?.layer.cornerRadius = 8
            shadow?.backgroundColor = .clear
            shadow?.layer.masksToBounds = false
            shadow?.layer.shadowColor = UIColor.black.cgColor
            shadow?.layer.shadowRadius = 1.5
            shadow?.layer.shadowOpacity = 0.5
            shadow?.layer.shadowOffset = .init(width: -5, height: 5)
            let radius = view!.layer.cornerRadius
            shadow?.layer.shadowPath = UIBezierPath(roundedRect: view!.bounds, cornerRadius: radius).cgPath
            //изначальное состояние cell
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 30, 0)
            cell.layer.transform = transform
            //состояние после прогрузки
            UIView.animate(withDuration: 1) {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            }
            
        }
    }

