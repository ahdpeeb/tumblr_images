//
//  UIViewController+Allert.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func displayAlert(title: String? = "Error".localized, message: String?, okBlock: SimpleClosure? = nil) {
        let allert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok".localized, style: .default) { _ in
            okBlock?()
        }

        allert.addAction(okAction)
        
        self.present(allert, animated: true)
    }
    
    func displayRequiredLoginPopUP() {
        let title = "Login to conntinue".localized
        let message = "You should Log in to perform this action".localized
        let allert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "CANCEL".localized, style: .cancel, handler: nil)
        let loginButton = UIAlertAction(title: "LOG IN".localized, style: .default) { (action) in
        }
        
        [cancelButton, loginButton].forEach({ allert.addAction($0) })
        self.present(allert, animated: true, completion: nil)
    }
}

