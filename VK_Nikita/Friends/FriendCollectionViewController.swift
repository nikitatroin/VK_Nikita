//
//  FriendCollectionViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var avatar = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(R.Cell.friendCollectionCell, forCellWithReuseIdentifier: R.Identifier.friendCollectionCell)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

extension FriendCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: R.Identifier.friendCollectionCell, for: indexPath)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let contentSize = self.collectionView.frame.width
        let rowHeight: CGFloat = 300
        let rowWidht = contentSize
    
        return .init(width: rowWidht, height: rowHeight)
    }
    
    
}

extension FriendCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? FriendsCollectionViewCell)?.configure(avatar: self.avatar)
        
    }
    
    
    
}
