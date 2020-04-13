//
//  ApiKeys.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/03.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation

enum ApiKey: String {
    case key
}

class ApiKeys {
    
    static var getKey: String {
        
        guard let file = Bundle.main.url(forResource: "apikey", withExtension: "json") else { return "" }
        do {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let object = json as? NSDictionary,
                let promiseKey = object.value(forKey: ApiKey.key.rawValue) as? String else {
                return "" }
            
            return promiseKey
            
        } catch { return "" }
    }
}
