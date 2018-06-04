//
//  ViewController.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit

class PhotosListViewController: UIViewController {
    
    fileprivate var imageWidth: CGFloat = 300.0
    fileprivate var cellMargin: CGFloat = 8.0
    
    @IBOutlet fileprivate var tableView: UITableView? {
        didSet {
            self.configureTableView()
        }
    }
    
    private var images: [Image] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadImages(tag: "lo")
    }
}

private extension PhotosListViewController {
    func configureTableView() {
        self.tableView?.rowAutoHeight(estimatedRowHeight: 44.0)
        self.tableView?.registerCell(ImageTableViewCell.self)
        self.tableView?.tableFooterView = UIView()
    }
    
    func loadImages(tag: String) {
        ApiClient.shared.loadImages(tag: tag, onSuccess: { (images) in
            self.images = images
        }) { (error) in
            self.displayAlert(message: error.localizedDescription)
        }
    }
}

extension PhotosListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cls: ImageTableViewCell.self, indexPath: indexPath)
        let model = self.images[indexPath.row]
        cell.model = model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let photo = self.images[indexPath.row].photo else { return 0.0 }
        let scaleFactor: CGFloat = CGFloat(photo.width ?? 0) / imageWidth
        
        return CGFloat(photo.height ?? 0.0) / scaleFactor + cellMargin * 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

