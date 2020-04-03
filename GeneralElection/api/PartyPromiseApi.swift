//
//  PartyPromiseApi.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/03.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation

class PartyPromiseApi: ApiBase<PartyPromiseBaseResponse> {
    
    init(partyName: String) {
        super.init()
        self.params = ["resultType": "json",
                       "serviceKey": ApiKeys.partyPromise,
                       "sgId": "20200415",
                       "partyName": partyName]
    }
    
    override var path: String {
        return "9760000/PartyPlcInfoInqireService/getPartyPlcInfoInqire"
    }
}
