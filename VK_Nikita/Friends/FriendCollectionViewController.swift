//
//  FriendCollectionViewController.swift
//  VK_Nikita
//
//  Created by Никита Троян on 13.09.2021.
//

import UIKit

class FriendCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [UIImage?] = []
    var photosURL: [Size?] = []
    var selcetedIndexPath:IndexPath!
    
    private var layout = CollectionViewCustomLayout()

    override func viewDidLoad() {
        self.photos = convertURLtoImage()
        super.viewDidLoad()
        collectionView.register(R.Cell.friendCollectionCell, forCellWithReuseIdentifier: R.Identifier.friendCollectionCell)
        configureCollectionView()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func convertURLtoImage () -> [UIImage?] {
        var imageContener: [UIImage] = []
        for photoURL in photosURL {
            guard let data = try? Data(contentsOf: URL(string: photoURL!.url)!) else { return [UIImage()] }
            imageContener.append(UIImage(data: data)!)
        }
        return imageContener
    }

    
    private func configureCollectionView () {
        self.collectionView.collectionViewLayout = self.layout
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detailVC = segue.destination as! DetailPhotoVC
            detailVC.image = sender as! UIImage?
        }
    }
}


extension FriendCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.Identifier.friendCollectionCell, for: indexPath) as! FriendsCollectionViewCell
        
        cell.avatar.image = photos[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = self.photos[indexPath.row]
        self.selcetedIndexPath = indexPath
        self.performSegue(withIdentifier: "ShowDetail", sender: image)
    }
    
}

extension FriendCollectionViewController:ZoomingViewController
{
    func zoomingImageView(for translition: ZoomTransitioningDelegate) -> UIImageView? {
        if let indexPath = self.selcetedIndexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! FriendsCollectionViewCell
            return cell.avatar
        }
        return nil
    }
    
    func zoomingBackgroundView(for translition: ZoomTransitioningDelegate) -> UIView? {
        return nil
    }
    
    
}

