//
//  ConcurrencyTableViewCell.swift
//  VK_Nikita
//
//  Created by Никита Троян on 01.12.2021.
//

import UIKit

final class ConcurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tImage: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    

    var imageURL: URL? {
        didSet {
            tImage.image = nil
            updateUI()
        }
    }
    
    private func updateUI() {
        if let imageURL = imageURL {
            spinner.startAnimating()
            let queue = DispatchQueue.global(qos: .background)
            queue.async {
                let contentOfURL = try? Data(contentsOf: imageURL)
                let mainQueue = DispatchQueue.main
                mainQueue.async {
                    if imageURL == self.imageURL {
                        if let imageData = contentOfURL {
                            self.tImage.contentMode = .scaleAspectFit
                            self.tImage.image = UIImage(data: imageData)
                        }
                        self.spinner.stopAnimating()
                    }
                }
            }
        }
    }
}
