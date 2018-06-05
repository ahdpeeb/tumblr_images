//
//  ImageTableViewCell.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit
import SDWebImage

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate var photoImageView: UIImageView?
    
    public var model: PhotoDisplayable? {
        didSet {
            self.setapImage(model?.photo?.imageURL)
        }
    }
    
    public var loadedImage: UIImage? {
        get {
            return self.photoImageView?.image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setapImage(_ url: URL?) {
        self.photoImageView?.sd_setIndicatorStyle(.gray)
        self.photoImageView?.sd_setShowActivityIndicatorView(true)
        self.photoImageView?.sd_setImage(with: url, placeholderImage: nil, options: [], completed: nil)
    }
}
