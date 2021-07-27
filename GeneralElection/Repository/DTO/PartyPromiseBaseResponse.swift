//
//  PartyPromiseBaseResponse.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/03.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation

struct PartyPromiseBaseResponse: Decodable {
    var getPartyPlcInfoInqire: PartyPlcInfoInqire?

    struct PartyPlcInfoInqire: Decodable {
        var header: Header?
        var item: [PartyPromise]?
        var numOfRows: Int?
        var pageNo: Int?
        var totalCount: Int?
        
        class Header: Decodable {
            var code: String?
            var message: String?
        }
    }

}
