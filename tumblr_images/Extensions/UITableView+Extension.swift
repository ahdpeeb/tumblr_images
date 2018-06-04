//
//  File.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import UIKit

extension UITableView  {
    //DESC: cell csl should macth to identifier
    func headerViewFromCell<T: UITableViewCell>(cls: T.Type) -> UIView {
        let identifier = String(describing: cls.self)
        let cell = self.dequeueReusableCell(withIdentifier: identifier)!
        
        let containerView = UIView(frame: cell.frame)
        cell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(cell)
        
        return containerView
    }
    
    // DESC: cls name should match with cell identifier
    func registerCell<T: UITableViewCell>(_ cls: T.Type) {
        let name = String(describing: cls.self)
        let cell = UINib.init(nibName: name, bundle: nil)
        self.register(cell, forCellReuseIdentifier: name)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(cls: T.Type) {
        let name = String(describing: cls.self)
        let nib = UINib.init(nibName: name, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: name)
    }
    
    func dequeueHeader<T>(cls: T.Type) -> T {
        let clsString = String(describing: T.self)
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: clsString) as? T else {
            fatalError("Expected header to be of type \(T.self)")
        }
        
        return header
    }
    
    func dequeueCell<T>(cls: T.Type, indexPath path: IndexPath) -> T {
        let clsString = String(describing: T.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: clsString, for: path) as? T else {
            fatalError("Expected cell to be of type \(T.self)")
        }
        
        return cell
    }
    
    func cell<T>(path: IndexPath) -> T? {
        return self.cellForRow(at: path) as? T
    }
    
    func update(_ block: (() -> ())? = nil) {
        self.beginUpdates()
        block?()
        self.endUpdates()
    }
    
    func rowAutoHeight(estimatedRowHeight : CGFloat) {
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = estimatedRowHeight
    }
    
    func reloadRowsNoAnimationAt(paths: [IndexPath], animation: UITableViewRowAnimation = .none) {
        let offset = self.contentOffset
        UIView.setAnimationsEnabled(false)
        self.update({
            self.reloadRows(at: paths, with: animation)
        })
        
        self.setContentOffset(offset, animated: false)
        UIView.setAnimationsEnabled(true)
    }
}
