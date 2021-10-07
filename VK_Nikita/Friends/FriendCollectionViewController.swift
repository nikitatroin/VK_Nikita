//
//  FriendCollectionViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
     var avatar:[UIImage?] = []
    private var layout = CollectionViewCustomLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(R.Cell.friendCollectionCell, forCellWithReuseIdentifier: R.Identifier.friendCollectionCell)
        configureCollectionView()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func configureCollectionView () {
        self.collectionView.collectionViewLayout = self.layout
    }
}

    extension FriendCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            avatar.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.Identifier.friendCollectionCell, for: indexPath) as! FriendsCollectionViewCell
            
            cell.avatar.image = avatar[indexPath.row]
            
            return cell

        }
        
        
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            
        }
    }

