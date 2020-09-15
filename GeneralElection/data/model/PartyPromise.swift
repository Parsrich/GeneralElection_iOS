//
//  PartyPromise.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/03.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation

class PartyPromise: Decodable {
    
    var num: String?
    var sgId: String?
    var partyName: String?
    var prmsCnt: String?
    
    private var prmsOrd1: String?
    private var prmsRealmName1: String?
    private var prmsTitle1: String?
    private var prmmCont1: String?
    
    private var prmsOrd2: String?
    private var prmsRealmName2: String?
    private var prmsTitle2: String?
    private var prmmCont2: String?
    
    private var prmsOrd3: String?
    private var prmsRealmName3: String?
    private var prmsTitle3: String?
    private var prmmCont3: String?
    
    private var prmsOrd4: String?
    private var prmsRealmName4: String?
    private var prmsTitle4: String?
    private var prmmCont4: String?
    
    private var prmsOrd5: String?
    private var prmsRealmName5: String?
    private var prmsTitle5: String?
    private var prmmCont5: String?
    
    private var prmsOrd6: String?
    private var prmsRealmName6: String?
    private var prmsTitle6: String?
    private var prmmCont6: String?
    
    private var prmsOrd7: String?
    private var prmsRealmName7: String?
    private var prmsTitle7: String?
    private var prmmCont7: String?
    
    private var prmsOrd8: String?
    private var prmsRealmName8: String?
    private var prmsTitle8: String?
    private var prmmCont8: String?
    
    private var prmsOrd9: String?
    private var prmsRealmName9: String?
    private var prmsTitle9: String?
    private var prmmCont9: String?
    
    private var prmsOrd10: String?
    private var prmsRealmName10: String?
    private var prmsTitle10: String?
    private var prmmCont10: String?
    
    
    var promiseList: [Promise] {
        var promises = [Promise]()
        
        promises.append(Promise(ord: prmsOrd1,
                                realmName: prmsRealmName1,
                                title: prmsTitle1,
                                content: prmmCont1))
        promises.append(Promise(ord: prmsOrd2,
                                realmName: prmsRealmName2,
                                title: prmsTitle2,
                                content: prmmCont2))
        promises.append(Promise(ord: prmsOrd3,
                                realmName: prmsRealmName3,
                                title: prmsTitle3,
                                content: prmmCont3))
        promises.append(Promise(ord: prmsOrd4,
                                realmName: prmsRealmName4,
                                title: prmsTitle4,
                                content: prmmCont4))
        promises.append(Promise(ord: prmsOrd5,
                                realmName: prmsRealmName5,
                                title: prmsTitle5,
                                content: prmmCont5))
        promises.append(Promise(ord: prmsOrd6,
                                realmName: prmsRealmName6,
                                title: prmsTitle6,
                                content: prmmCont6))
        promises.append(Promise(ord: prmsOrd7,
                                realmName: prmsRealmName7,
                                title: prmsTitle7,
                                content: prmmCont7))
        promises.append(Promise(ord: prmsOrd8,
                                realmName: prmsRealmName8,
                                title: prmsTitle8,
                                content: prmmCont8))
        promises.append(Promise(ord: prmsOrd9,
                                realmName: prmsRealmName9,
                                title: prmsTitle9,
                                content: prmmCont9))
        promises.append(Promise(ord: prmsOrd10,
                                realmName: prmsRealmName10,
                                title: prmsTitle10,
                                content: prmmCont10))
        return promises
    }
    
}


class Promise {
    var ord: String?
    var realmName: String?
    var title: String?
    var content: String?
    
    init(ord: String?, realmName: String?, title: String?, content: String?) {
        self.ord = ord
        self.realmName = realmName
        self.title = title
        self.content = content
    }
}
