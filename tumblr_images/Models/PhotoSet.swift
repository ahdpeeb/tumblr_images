//
//  PhotoSet.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import ObjectMapper

final class PhotoSet: Mappable {
    var caption: String?
    var original: Photo?
    var allSizes: [Photo]?
    
    public var placeholderPhoto: Photo? {
        return self.allSizes?.last
    }
    
    //MARK: Mappable
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.caption <- map["caption"]
        self.original <- map["original_size"]
        self.allSizes <- map["alt_sizes"]
    }
}
