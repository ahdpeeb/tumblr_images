
//
//  Constans.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class AbstractApiClient: NSObject {
    public func loadObject<T: BaseMappable>(url: String,
                      method: HTTPMethod = .get,
                     options: AnyDict?,
                    encoding: ParameterEncoding = URLEncoding.default,
                     headers: StringDict? = nil,
                    onResult: ((_ result: T?) -> Void)?,
                     onError: ErrorClosure? = nil)
    {
        let requst = Alamofire.request(url, method: method, parameters: options, encoding: encoding, headers: headers)
        requst.responseJSON { (responseInfo) in
            if let error = self.errorResponseValidation(responseInfo) {
                onError?(error)
                return
            }
            
            guard let json = responseInfo.result.value as? AnyDict else {
                let error = Constans.ErrorMessage.JSONdeserelization.toError()
                onError?(error)
                return
            }
            
            if let error = self.errorFromJSONResponce(json) {
                onError?(error)
                return
            }
            
            let TMappable = T.self as? Mappable.Type
            let model = TMappable?.init(JSON: json, context: nil) as? T
            onResult?(model)
        }
    }
    
    public func loadObjects<T: Mappable>(url: String,
                           method: HTTPMethod = .get,
                           options: AnyDict?,
                           encoding: ParameterEncoding = URLEncoding.default,
                           headers: StringDict? = nil,
                           onResult: ((_ result: [T]) -> Void)?,
                           onError: ErrorClosure? = nil)
    {
        let requst = Alamofire.request(url, method: method, parameters: options, encoding: encoding, headers: headers)
        requst.responseJSON { (responseInfo) in
            if let error = self.errorResponseValidation(responseInfo) {
                onError?(error)
                return
            }
            
            guard let jsons = responseInfo.result.value as? [AnyDict] else {
                let error = Constans.ErrorMessage.JSONCollectionDeserelization.toError()
                onError?(error)
                return
            }
            
            let objects: [T] = jsons.compactMap({ T.self.init(JSON: $0, context: nil) })
            onResult?(objects)
        }
    }
    
    ///Validate response, if response valid = return nil
    private func errorResponseValidation(_ serverResponse: DataResponse<Any>) -> Error? {
        //DESC: if no response -> interner connection error
        guard let info = serverResponse.response else {
            return Constans.ErrorMessage.internetConnection.toError()
        }
        
        //DESC: case for bad status code or if no result value
        let statusCode = info.statusCode
        guard 200..<300 ~= statusCode else {
            // bad status code, serverResponse.value, could contain erro message
            return serverResponse.error ?? serverResponse.result.error
        }
        
        return nil
    }
    
    private func errorFromJSONResponce(_ json: [String: Any]) -> Error? {
        guard let code = json["cod"] as? Int else { return nil }
        guard 200..<300 ~= code else {
            // bad status code, serverResponse.value, could contain erro message
           let errorMessage = (json["message"] as? String)
           return errorMessage?.toError()
        }
        
        return nil
    }
}
