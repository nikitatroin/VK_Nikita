//
//  FirendViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendViewController: UIViewController {
    
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction func logout(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController") as? ViewController
        vc!.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    var displayItem: [Users] = [
        .init(name: "Nikita", avatar: UIImageView(image: UIImage(imageLiteralResourceName: "Я")), lastname: "Troyan")
        ]
    
    private var userPhotos: [UsersAvatar] = [
        .init(avatar: UIImageView(image: UIImage(imageLiteralResourceName: "Я")))
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(R.Cell.friendTableCell, forCellReuseIdentifier: R.Identifier.friendTableCell)
 
    }

}

extension FriendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.Identifier.friendTableCell, for: indexPath)
    }
    
}

extension FriendViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? FriendsTableViewCell)?.configure(userInfo: displayItem[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "friendCollectionVC") as? FriendCollectionViewController
        vc?.avatar = displayItem[indexPath.row].avatar
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}

