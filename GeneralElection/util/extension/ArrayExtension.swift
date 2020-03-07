//
//  ArrayExtension.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    mutating func remove(_ obj: Element) -> Bool {
        if let idx = self.firstIndex(of: obj) {
            self.remove(at: idx)
            return true
        }
        return false
    }
}
