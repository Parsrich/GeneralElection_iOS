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
    private var prmsCont1: String?
    
    private var prmsOrd2: String?
    private var prmsRealmName2: String?
    private var prmsTitle2: String?
    private var prmsCont2: String?
    
    private var prmsOrd3: String?
    private var prmsRealmName3: String?
    private var prmsTitle3: String?
    private var prmsCont3: String?
    
    private var prmsOrd4: String?
    private var prmsRealmName4: String?
    private var prmsTitle4: String?
    private var prmsCont4: String?
    
    private var prmsOrd5: String?
    private var prmsRealmName5: String?
    private var prmsTitle5: String?
    private var prmsCont5: String?
    
    private var prmsOrd6: String?
    private var prmsRealmName6: String?
    private var prmsTitle6: String?
    private var prmsCont6: String?
    
    private var prmsOrd7: String?
    private var prmsRealmName7: String?
    private var prmsTitle7: String?
    private var prmsCont7: String?
    
    private var prmsOrd8: String?
    private var prmsRealmName8: String?
    private var prmsTitle8: String?
    private var prmsCont8: String?
    
    private var prmsOrd9: String?
    private var prmsRealmName9: String?
    private var prmsTitle9: String?
    private var prmsCont9: String?
    
    private var prmsOrd10: String?
    private var prmsRealmName10: String?
    private var prmsTitle10: String?
    private var prmsCont10: String?
    
    
    var promiseList: [Promise] {
        var promises = [Promise]()
        
        promises.append(Promise(ord: prmsOrd1,
                                realmName: prmsRealmName1,
                                title: prmsTitle1,
                                content: prmsCont1))
        promises.append(Promise(ord: prmsOrd2,
                                realmName: prmsRealmName2,
                                title: prmsTitle2,
                                content: prmsCont2))
        promises.append(Promise(ord: prmsOrd3,
                                realmName: prmsRealmName3,
                                title: prmsTitle3,
                                content: prmsCont3))
        promises.append(Promise(ord: prmsOrd4,
                                realmName: prmsRealmName4,
                                title: prmsTitle4,
                                content: prmsCont4))
        promises.append(Promise(ord: prmsOrd5,
                                realmName: prmsRealmName5,
                                title: prmsTitle5,
                                content: prmsCont5))
        promises.append(Promise(ord: prmsOrd6,
                                realmName: prmsRealmName6,
                                title: prmsTitle6,
                                content: prmsCont6))
        promises.append(Promise(ord: prmsOrd7,
                                realmName: prmsRealmName7,
                                title: prmsTitle7,
                                content: prmsCont7))
        promises.append(Promise(ord: prmsOrd8,
                                realmName: prmsRealmName8,
                                title: prmsTitle8,
                                content: prmsCont8))
        promises.append(Promise(ord: prmsOrd9,
                                realmName: prmsRealmName9,
                                title: prmsTitle9,
                                content: prmsCont9))
        promises.append(Promise(ord: prmsOrd10,
                                realmName: prmsRealmName10,
                                title: prmsTitle10,
                                content: prmsCont10))
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
