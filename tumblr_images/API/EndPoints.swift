//
//  EndPoints.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import Alamofire

enum EndPoins {
    case getImages(tag: String, batchCount: Int)
    
    var url: String {
        switch self {
        case .getImages(_, _): return ApiConstans.ApiPaths.getImages
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var parametres: [String: Any] {
        switch self {
        case .getImages(let tag, let batchCount): return self.getImagedParametres(tag: tag, batchCount: batchCount)
        }
    }
    
    var encoding: Alamofire.ParameterEncoding {
        switch self {
        default: return Alamofire.URLEncoding.default
        }
    }
}

fileprivate extension EndPoins {
    func getImagedParametres(tag: String, batchCount: Int) -> [String: Any] {
        return [
            QueryKeys.tag: tag,
            QueryKeys.couns: batchCount,
            QueryKeys.apiKey: Constans.TumblrApi.apiKey,
        ]
    }
}
