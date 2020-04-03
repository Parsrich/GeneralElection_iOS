//
//  ApiKeys.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/03.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation

enum ApiKey: String {
    case partyPromise
}

class ApiKeys {
    
    static var partyPromise: String {
        
        guard let file = Bundle.main.url(forResource: "apikey", withExtension: "json") else { return "" }
        do {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let object = json as? NSDictionary,
                let promiseKey = object.value(forKey: ApiKey.partyPromise.rawValue) as? String else {
                return "" }
            
            return promiseKey
            
        } catch { return "" }
    }
}
