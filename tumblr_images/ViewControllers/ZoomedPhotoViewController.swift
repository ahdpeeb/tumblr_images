//
//  ZoomedPhotoViewController.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/5/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit

class ZoomedPhotoViewController: UIViewController {
    @IBOutlet fileprivate var imageView: UIImageView!
    @IBOutlet fileprivate var scrollView: UIScrollView!
    @IBOutlet fileprivate var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var imageViewTrailingConstraint: NSLayoutConstraint!
    
    public var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImage(image)
    }
}
//MARK: Private
private extension ZoomedPhotoViewController {
    func setImage(_ image: UIImage?) {
        self.imageView.image = image
        
        UIView.animate(withDuration: 0, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.updateMinZoomScaleForSize(self.scrollView.frame.size)
            self.updateConstraintsForSize(self.scrollView.frame.size)
        }
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / image.size.width
        let heightScale = size.height / image.size.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        let imageHeight = imageView.frame.height
        let yOffset = max(0, (size.height - imageHeight) / 2)
        let navBarHeigh = self.navigationController?.navigationBar.frame.height ?? 0.0
        imageViewTopConstraint.constant = yOffset - navBarHeigh / 2
        imageViewBottomConstraint.constant = yOffset + navBarHeigh / 2
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
}

extension ZoomedPhotoViewController: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.updateConstraintsForSize(scrollView.bounds.size)
    }
}
