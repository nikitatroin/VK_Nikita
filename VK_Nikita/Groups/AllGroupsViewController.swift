//
//  AllGropsViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class AllGroupsViewController: UIViewController {
    

    @IBOutlet weak var tableVIew: UITableView!
    
     var displayItem: [Groups] = [
        .init(name: "Cars", image: UIImage(imageLiteralResourceName: "Машина"))
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension AllGroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.Identifier.groupsTableCell, for: indexPath) as! GroupsTVC

        cell.avatar.image = displayItem[indexPath.row].image
        cell.name.text = displayItem[indexPath.row].name
        
        return cell
    }
}

   
    

