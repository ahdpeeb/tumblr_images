//
//  Codable+Extension.swift
//  tumblr_images
//
//  Created by Nikola Andriiev on 6/4/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation

extension Encodable {
    func toJson() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
}

extension Dictionary {
    func toModel<T: Decodable>(_ type: T.Type) -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: self,
                                                            options: .prettyPrinted)
            else { return nil }
        
        do {
            let model: T = try JSONDecoder().decode(type.self, from: data)
            return model
        } catch let error {

            #if debag
                let errorMessage = String(format: "DEBAG: $0 ", error.localizedDescription)
                print(errorMessage)
            #endif
           
            return nil
        }
    }
}
