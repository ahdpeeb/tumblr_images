//
//  ApiClient.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation

typealias ImagesCompletion = (_ images: [Image]) -> Void

final class ApiClient: AbstractApiClient {
    static let shared = ApiClient()
    
    private override init() {
    }
    
    func loadImages(tag: String, count: Int = 20, onSuccess: ImagesCompletion?, onError: ErrorClosure?) {
        let api = EndPoins.getImages(tag: tag, batchCount: count)
        self.loadObjects(url: api.url, method: api.method, options: api.parametres, encoding: api.encoding, headers: nil, onResult: onSuccess, onError: onError)
    }
}
