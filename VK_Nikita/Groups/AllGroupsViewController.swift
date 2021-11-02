//
//  AllGropsViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class AllGroupsViewController: UIViewController {
    
    let groupAPI = GroupApi()
    
    @IBOutlet weak var tableVIew: UITableView!
    
     var displayItem: [Groups] = []
     var groupPhotos: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupAPI.getGroups { [weak self] group in
            guard let self = self else { return }
            self.displayItem = group
            self.groupPhotos = self.convertURLtoImage()
            self.tableVIew.reloadData()
        }
        
    }
    
    private func convertURLtoImage () -> [UIImage?] {
        var imageContener: [UIImage?] = []
        for photoURL in displayItem {
            guard let data = try? Data(contentsOf: URL(string: photoURL.photo)!) else { return [UIImage()] }
            imageContener.append(UIImage(data: data)!)
        }
        return imageContener
    }
    
}

extension AllGroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.Identifier.groupsTableCell, for: indexPath) as! GroupsTVC

        cell.avatar.image = groupPhotos[indexPath.row]
        cell.name.text = displayItem[indexPath.row].name
        
        return cell
    }
}

   
    

