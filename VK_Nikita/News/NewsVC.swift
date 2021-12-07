//
//  NewsVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 27.09.2021.
//

import UIKit
import Alamofire

final class NewsVC: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private let newsService = NewsApi()
    private var response:[Item] = []
    var operationResponse:[Items] = []
    let opq = OperationQueue()
    let url = "https://api.vk.com/method/newsfeed.get"
    let parameters = [
        "user_id": Session.shared.userId,
        "access_token": Session.shared.token,
        "v": "5.81",
        "filters": "post",
        "count": "1"
    ]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        let getDataOperation = GetNewsOperation(parameters: parameters, url: url)
        getDataOperation.completionBlock = {
            print(getDataOperation.data?.prettyJSON as Any)
        }
        opq.addOperation(getDataOperation)
        
        let parseDataOperation = OperationParseData()
        parseDataOperation.addDependency(getDataOperation)

        opq.addOperation(parseDataOperation)
        
        let reloadDataOperation = RelodNews(controller: self)
        reloadDataOperation.addDependency(parseDataOperation)

        opq.addOperation(reloadDataOperation)
        
        
        super.viewDidLoad()
        self.navigationItem.title = "News"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: R.Identifier.newsCell)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}



extension NewsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //получаем доступ к нашей ячейке
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.Identifier.newsCell, for: indexPath) as! NewsCell
        // загружаем объекты
        
//        self.newsService.getNews { (response) in
//            switch response {
//            case .success(let items):
//                if let items = items {
//                    self.response = items
//                    DispatchQueue.main.async {
//                        self.collectionView.reloadData()
//                    }
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        //проверяем, что нам есть, что выводить, а иначе выводим балванку
        guard operationResponse.isEmpty != true else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: R.Identifier.newsCell, for: indexPath) as! NewsCell
        }
        // если есть то вставялем данные
        let item = response[indexPath.row]
        cell.statusTextView.text = item.text
        
        if let url = URL(string: item.attachments[0].photo?.sizes[0].url ?? ""){
        cell.statusImageView.load(url: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    
}


extension NewsVC: UICollectionViewDelegate {
    
}
