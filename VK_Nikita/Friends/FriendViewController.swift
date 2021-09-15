//
//  FirendViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logout"
                {
                    if let vc = segue.destination as? ViewController
                    {
                        vc.modalPresentationStyle = .fullScreen

                    }
                }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(R.Cell.friendTableCell, forCellReuseIdentifier: R.Identifier.friendTableCell)
        
    }
    
    private var displayItem: [Users] = [
        .init(name: "Nikita", lastname: "Troyan", avatar: UIImageView(image: UIImage(imageLiteralResourceName: "Я")))
        ]



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
    
    
}

