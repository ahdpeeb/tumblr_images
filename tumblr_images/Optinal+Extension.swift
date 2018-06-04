//
//  Optinal+Extension.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation

extension Optional {
    func `do`(_ execute: (Wrapped) -> ()) {
        self.map(execute)
    }
}
