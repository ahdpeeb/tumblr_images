//
//  ViewController.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit

class PhotosListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadImages(tag: "lol")
    }
}

private extension PhotosListViewController {
    func loadImages(tag: String) {
        ApiClient.shared.loadImages(tag: tag, onSuccess: { (pictures) in
            print(pictures.count)
        }) { (error) in
            self.displayAlert(message: error.localizedDescription)
        }
    }
}

