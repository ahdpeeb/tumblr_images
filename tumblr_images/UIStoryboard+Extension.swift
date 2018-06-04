//
//  UIStoryboard + Extension.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    // return viewControlle from main storyboard
    static func controllerFromMainStorybourd<T>(cls: T.Type) -> T? {
        return self.controllerFromStorybourd("Main", cls: cls)
    }
    
    // return viewController based on in class from storybourd with particular name
    static func controllerFromStorybourd<R>(_ name: String, cls: R.Type) -> R? {
        let stringFromClass = String(describing: cls)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: stringFromClass) as? R
    }
    
    static func initialControllerFromStorybourd<R>(_ name: String) -> R? {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateInitialViewController() as? R
    }
    
    class func viewController(_ storyboard: String, identifier: String) -> UIViewController {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}
