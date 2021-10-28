//
//  NetworkFriendsVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 23.10.2021.
//

import UIKit

class FriendsVC: UITableViewController {
    
    //подключили все наши API
    let friendsApi = FriendsApi()
    let groupApi = GroupApi()
    let photoApi = PhotoApi()
    
    // создали контейнер для друзей
    var friends: [Friend4] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        //разбили сильную ссылку и использовав [weak self], иначе наш контроллер не будет выводится из памяти и произойдёт утечка
        friendsApi.getFriendsAlamofire { [weak self] friends in
            
            //напомню себе, что мы когда объявляли метод, указали в параметрах, что должны передавать "убегающий" closure, а в нём у нас как параметром заявлен массив тип Friend1, который хранит id, firstname, lastname и фото
            
            //затем внутри метода снова сделали ссылку сильной, чтобы closure выполнил свою работу, вопрос в другом, нужно ли нам, чтобы он её выполнял после того как контроллер уже был удалён из памяти
            guard let self = self else { return }
            print("Getted friends")
            //closure с информацией был получен и данные были записаны контейнер с друзьями в этом контроллере
            self.friends = friends
            //как только метод заврешился, обновляем таблицу
            self.tableView.reloadData()
        }
        */
        
        friendsApi.getFriends4URLSession { [weak self] friends in
            guard let self = self  else { return }
            self.friends = friends
            self.tableView.reloadData()
        }
        
        
//        friendsApi.getFriends3URLSession { [weak self] friends in
//            guard let self = self  else { return }
//            self.friends = friends
//            self.tableView.reloadData()
//        }
//
//        friendsApi.getFriends2URLSession { [weak self] friends in
//            guard let self = self else { return }
//            self.friends = friends
//            self.tableView.reloadData()
//        }
        
//        friendsApi.getFriendsURLSession { [weak self] friends in
//            guard let  self = self else { return }
//            self.friends = friends
//            self.tableView.reloadData()
//        }
        
//        photoApi.getPhotos { friend in
//            print("Getted photos")
//        }

//        groupApi.getGroups { friend in
//            print("Getted groups")
//        }
        
//        groupApi.getGruopsAlamofire { friend in
//            print("Getted groups")
//        }
        
//        groupApi.getGroupsSearch { friend in
//            print("Get searched groups")
//        }
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = friends[indexPath.row].firstName + " " + friends[indexPath.row].lastName
        cell.imageView?.image = UIImage(systemName: "heart")

        return cell
    }

}
