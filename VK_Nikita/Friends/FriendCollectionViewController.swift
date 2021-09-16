//
//  FriendCollectionViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendCollectionViewController: UIViewController {
    
    let collectionView:UICollectionView = {
       let collection = UICollectionView()
        collection.register(R.Cell.friendCollectionCell, forCellWithReuseIdentifier: R.Identifier.friendCollectionCell)
       return collection
   }()
    
    var userPhotos: [UIImageView] = []
    
    init(userPhotos:[UIImageView]) {
        self.userPhotos = userPhotos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = .systemBackground
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension FriendCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: R.Identifier.friendCollectionCell, for: indexPath)
    }
    
    
}

extension FriendCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? FriendsCollectionViewCell)?.configure(avatar: userPhotos[indexPath.row])
    }
    
    
    
}
