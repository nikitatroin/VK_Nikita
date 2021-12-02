//
//  ConcurrencyTVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 01.12.2021.
//

import UIKit

final class ConcurrencyTVC: UITableViewController {
    
   private var imageURLs: [String] =
            ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
             "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
             "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png",
             "https://www.nawpic.com/media/2020/galaxy-background-nawpic-4.jpg",
             "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
             "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
             "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png",
             "https://www.nawpic.com/media/2020/galaxy-background-nawpic-4.jpg"]

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageURLs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath) as! ConcurrencyTableViewCell
        cell.imageURL = URL(string: imageURLs[indexPath.row])
        return cell
    }
}
