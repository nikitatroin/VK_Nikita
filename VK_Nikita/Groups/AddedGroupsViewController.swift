//
//  AddedGroupsViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class AddedGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    @IBAction func segua (_ segua:UIStoryboardSegue) {
        if segua.identifier == "addGroup" {
            let vc = segua.source as! AllGroupsViewController
            if let indexPath = vc.tableVIew.indexPathForSelectedRow?.row {
                let group = vc.displayItem[indexPath]
                if !displayItem.contains(where: { _ in
                    guard displayItem[indexPath].image == group.image && displayItem[indexPath].name == group.name else {return false}
                    return true
                }) {
                displayItem.append(group)
                }
                tableVIew.reloadData()
            }
        }
        
    }
    
    var displayItem = [Groups]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableVIew.register(R.Cell.groupTableCell, forCellReuseIdentifier: R.Identifier.groupsTableCell)
    }
    
}

extension AddedGroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.Identifier.groupsTableCell, for: indexPath)
    }
}

extension AddedGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? GroupsTableViewCell)?.avatar = displayItem[indexPath.row].image
        (cell as? GroupsTableViewCell)?.labelName.text = displayItem[indexPath.row].name
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            displayItem.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }

}
    
