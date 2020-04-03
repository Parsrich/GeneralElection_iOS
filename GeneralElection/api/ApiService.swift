//
//  ApiService.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/03.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift

class ApiService {
    
    class func partyPromseApi(partyName: String) -> Observable<[PartyPromise]?> {
        let api = PartyPromiseApi(partyName: partyName)
        
        return api.request()
            .map {
                $0.getPartyPlcInfoInqire?.item
                
        }
    }
}
