//
//  NoneItemsTableViewCell.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit

final class NoneItemsTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var titleLabel: UILabel?
    
    var titleString: String? {
        didSet {
            titleLabel?.text = titleString
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
