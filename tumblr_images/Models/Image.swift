//
//  ImageModel.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import ObjectMapper

 protocol PhotoDisplayable {
    var photo: Photo? { get }
}

final class Image: Mappable, PhotoDisplayable {
    var id: Int!
    var date: String? //format: "2016-01-17 19:55:11 GMT"
    var timestamp: Int? //format: 1453060511
    var photos: [PhotoSet]?
    
    required init?(map: Map) {
        guard map.JSON["id"].flatMap({ $0 as? Int }) != nil else { return nil }
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.date <- map["date"]
        self.timestamp <- map["timestamp"]
        self.photos <- map["photos"]
    }
    
    //MARK: PhotoDisplayable
    
    // get middle resolutions from all images
    var photo: Photo? {
        guard let allSizes = self.photos?.first?.allSizes else { return nil }
        return allSizes[allSizes.count / 2]
    }
}
