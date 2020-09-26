//
//  CodableExtension.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

extension KeyedDecodingContainer {
    func decode<T>(_ key: KeyedDecodingContainer.Key) throws -> T where T: Decodable {
        return try decode(T.self, forKey: key)
    }
    func decodeArray<T>(_ key: KeyedDecodingContainer.Key) throws -> [T] where T: Decodable {
        return try decode([T].self, forKey: key)
    }
    
    func decodeIfPresent<T>(_ key: KeyedDecodingContainer.Key) throws -> T? where T: Decodable {
        return try decodeIfPresent(T.self, forKey: key)
    }
    
    subscript<T>(key: Key) -> () throws -> T where T: Decodable {
        return { try self.decode(T.self, forKey: key) }
    }
}
