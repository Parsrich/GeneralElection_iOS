//
//  Congress.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/25.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation

class Congress {
    
    static var congressDict: NSDictionary?
    static var guMayorDict: NSDictionary?
    static var siCouncilDict: NSDictionary?
    static var guCouncilDict: NSDictionary?
    
    static func reset() {
        congressDict = nil
        guMayorDict = nil
        siCouncilDict = nil
        guCouncilDict = nil
    }
}
