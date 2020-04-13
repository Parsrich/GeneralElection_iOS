//
//  VoteResultApi.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation
//sgId=20180613&sgTypecode=4&sggName=%EC%A2%85%EB%A1%9C%EA%B5%AC&sdName=%EC%84%9C%EC%9A%B8%ED%8A%B9%EB%B3%84%EC%8B%9C&wiwName=%EC%A2%85%EB%A1%9C%EA%B5%AC

class PartyPromiseApi: ApiBase<PartyPromiseBaseResponse> {
    
    init(partyName: String) {
        super.init()
        self.params = ["resultType": "json",
                       "serviceKey": ApiKeys.getKey,
                       "sgId": "20200415",
                       "partyName": partyName]
    }
    
    override var path: String {
        return "9760000/VoteXmntckInfoInqireService2/getXmntckSttusInfoInqire"
    }
}
