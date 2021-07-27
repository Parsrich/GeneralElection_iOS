//
//  Congress.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/25.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation

class Congress {
    static let shared = Congress()
    
    private init() { }
    
    var congressDict: NSDictionary?
    var guMayorDict: NSDictionary?
    var siCouncilDict: NSDictionary?
    var guCouncilDict: NSDictionary?
    
    func reset() {
        congressDict = nil
        guMayorDict = nil
        siCouncilDict = nil
        guCouncilDict = nil
    }
}
