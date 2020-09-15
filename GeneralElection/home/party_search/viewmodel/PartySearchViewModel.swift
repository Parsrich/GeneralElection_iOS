//
//  PartySearchViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/13.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import NSObject_Rx

class PartySearchViewModel: BaseViewModel {
    
    var partyList: [Party]
    
    required init() {
        self.partyList = [Party]()
        super.init()
    }
    
    func fetchPartyKeys(location: String? = nil, completion: @escaping () -> Void) {
        if PartyMemory.partyDict == nil {
            FirebaseHelper.fetchDatas(path: .proportional, key: location) .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.asyncInstance)
                .subscribe(onNext: { party in
                    PartyMemory.partyDict = party

                    }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                }).disposed(by: rx.disposeBag)
            return
        }
        
        bindData()
        completion()
    }
    
    func bindData() {
        setPartyCandidateList()
    }

    func setPartyCandidateList() {
        self.partyList.removeAll()        
        self.partyList = PartyMemory.partyDataList
    }
}
