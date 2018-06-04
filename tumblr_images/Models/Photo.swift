//
//  Photo.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import ObjectMapper

final class Photo: Mappable {
    var width: Float?
    var height: Float?
    var url: String?
    
    var imageURL: URL? {
        let urlString = self.url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return urlString.flatMap({ URL(string: $0) })
    }
    
    //MARK: Mappable
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.width <- map["width"]
        self.height <- map["height"]
        self.url <- map["url"]
    }
}
