//
//  String + extension.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func isBlank() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return trimmed.isEmpty
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func toError() -> NSError {
        return NSError(domain: String(),
                       code: 0,
                       userInfo: [NSLocalizedDescriptionKey : self])
    }
}
