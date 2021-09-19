//
//  AllGropsViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class AllGroupsViewController: UIViewController {

    @IBOutlet private weak var tableVIew: UITableView!
    
   
    
    private var displayItem: [Groups] = [
        .init(name: "Cars", image: UIImageView(image: UIImage(imageLiteralResourceName: "Машина")))
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableVIew.register(R.Cell.groupTableCell, forCellReuseIdentifier: R.Identifier.groupsTableCell)
    }
    
}



extension AllGroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: R.Identifier.groupsTableCell, for: indexPath)
    }


}

extension AllGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? GroupsTableViewCell)?.configure(displayItem[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "addedGroup") as? AddedGroupsViewController
        vc?.displayItem.append(displayItem[indexPath.row])
        navigationController?.pushViewController(vc!, animated: true)
    }

}
   
    

