//
//  PartyDetailViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/04.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import NSObject_Rx

class PartyDetailViewModel: BaseViewModel {
    
    // 정당 공약 볼때만 사용할 데이터
    var partyPromiseList: [Promise]?
    var partyName: String = ""
    
    required init() {
        super.init()
    }
    
    func fetchPartyPromise(location: String? = nil, errorHandler: @escaping (Error) -> Void, completion: @escaping () -> Void) {
        if PartyMemory.partyPromiseDict == nil {
            FirebaseHelper.fetchDatas(path: .partyPromise, key: location) .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.asyncInstance)
                .subscribe(onNext: { partyPromise in
                    PartyMemory.partyPromiseDict = partyPromise
                }, onError: { error in
                    errorHandler(error)
                }, onCompleted: { [weak self] in
                        self?.bindPartyPromise()
                        completion()
                }).disposed(by: rx.disposeBag)
            return
        }
        
        bindPartyPromise()
        completion()
    }
    
    func bindPartyPromise() {

        if self.partyPromiseList == nil {
            self.partyPromiseList = [Promise]()
        }
        if let promiseList = PartyMemory.partyPromiseData(name: partyName) {
            self.partyPromiseList?.append(contentsOf: promiseList)
        }
    }
}
