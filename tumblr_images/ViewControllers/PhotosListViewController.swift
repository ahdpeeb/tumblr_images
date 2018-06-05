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
    
    fileprivate var searchController = UISearchController(searchResultsController: nil)
    
    private var images: [Image] = [] {
        didSet {
            self.showNoItemsView(images.isEmpty)
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showNoItemsView(images.isEmpty)
    }
}

private extension PhotosListViewController {
    func configureTableView() {
        self.tableView?.registerCell(ImageTableViewCell.self)
        self.tableView?.tableFooterView = UIView()
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        let searchBar = searchController.searchBar
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        searchBar.sizeToFit()
        self.tableView?.tableHeaderView = searchBar
        definesPresentationContext = true
    }
    
    func showNoItemsView(_ value: Bool) {
        let view = UINib.view(NoneItemsTableViewCell.self)
        self.tableView?.backgroundView = value ? view : nil
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
        guard let photo = self.images[indexPath.row].photo else { return 2 }
        let scaleFactor: CGFloat = CGFloat(photo.width ?? 0) / self.imageWidth
        
        return CGFloat(photo.height ?? 0.0) / scaleFactor + self.cellMargin * 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PhotosListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension PhotosListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text ?? ""
        self.loadImages(tag: searchText)
    }
}
