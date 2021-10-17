//
//  DetailPhotoVC.swift
//  VK_Nikita
//
//  Created by Никита Троян on 12.10.2021.
//

import UIKit

class DetailPhotoVC: UIViewController {
    
    @IBOutlet weak var detailedPhoto: UIImageView! {
        didSet {
            self.detailedPhoto.image = image
        }
    }
    
    var image: UIImage!
    var images: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Photo"
    }
    
}

extension DetailPhotoVC: ZoomingViewController {
    
    func zoomingImageView(for translition: ZoomTransitioningDelegate) -> UIImageView? {
        return detailedPhoto
    }
    
    func zoomingBackgroundView(for translition: ZoomTransitioningDelegate) -> UIView? {
        return nil
    }
    
    
}
