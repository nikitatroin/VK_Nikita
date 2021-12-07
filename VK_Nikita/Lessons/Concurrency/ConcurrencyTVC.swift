//
//  ConcurrencyTVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 01.12.2021.
//

import UIKit
import Alamofire

final class ConcurrencyTVC: UITableViewController {
    
    var posts: [Post] = []
    var url = "https://jsonplaceholder.typicode.com/posts"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(url)
    }
    
   private var imageURLs: [String] =
            ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
             "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
             "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png",
             "https://www.nawpic.com/media/2020/galaxy-background-nawpic-4.jpg",
             "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
             "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
             "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png",
             "https://www.nawpic.com/media/2020/galaxy-background-nawpic-4.jpg"]
    
    private func getData(_ url: String){
        //создаём очередь
        let myOwnQueue = OperationQueue()
        //получаем данные
        let request = AF.request(url)
        let getDataOperation = GetDataOperation(request: request)
        //добавили операцию в очередь
        myOwnQueue.addOperation(getDataOperation)
        //распарсили данные
        let parseData = ParseOperation()
        //добавили зависимость от получения
        parseData.addDependency(getDataOperation)
        //добавили в очередь
        myOwnQueue.addOperation(parseData)
        
        let reloadTableViewController = ReloadTableController(controller: self)
        reloadTableViewController.addDependency(parseData)
        OperationQueue.main.addOperation(reloadTableViewController)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].body
        return cell
    }
}
