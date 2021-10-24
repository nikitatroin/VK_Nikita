//
//  NetworkFriendsVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 23.10.2021.
//

import UIKit

class NetworkFriendsVC: UITableViewController {
    
    let friendsApi = FriendsApi()
    
    var friends = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        friendsApi.getFriends { friend in
//            print("Getted friends")
//        }
        
//        friendsApi.getPhotos { friend in
//            print("Getted photos")
//        }

//        friendsApi.getGroups { friend in
//            print("Getted groups")
//        }
        
//        friendsApi.getGruopsAlamofire { friend in
//            print("Getted groups")
//        }
        
        friendsApi.getGroupsSeatch { friend in
            print("Get searched groups")
        }
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        guard cell.textLabel?.text != nil else { return UITableViewCell() }
        
        cell.textLabel?.text = friends[indexPath.row]

        return cell
    }

}
