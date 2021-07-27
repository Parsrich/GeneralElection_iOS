//
//  PartySearchViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/13.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift

class PartySearchViewModel: BaseViewModel {
    
    var partyList: [Party]
    
    override init() {
        self.partyList = [Party]()
        super.init()
    }
    
    func fetchPartyKeys(location: String? = nil, errorHandler: @escaping (Error) -> Void, completion: @escaping () -> Void) {
        if PartyMemory.partyDict == nil {
            FirebaseHelper.fetchDatas(path: .proportional, key: location) .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.asyncInstance)
                .subscribe(onNext: { party in
                    PartyMemory.partyDict = party

                }, onError: { error in
                    errorHandler(error)
                }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                }).disposed(by: disposeBag)
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
