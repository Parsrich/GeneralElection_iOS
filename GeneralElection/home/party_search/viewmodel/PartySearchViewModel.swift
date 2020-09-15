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
    
    var partyList: [Party]?
    
    required init() {
        super.init()
    }
    
    func fetchPartyKeys(location: String? = nil, completion: @escaping () -> Void) {
//        if District.districtDict == nil {
//            FirebaseHelper.fetchDatas(path: .district, key: location)
//                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//                .observeOn(MainScheduler.asyncInstance)
//                .subscribe(onNext: { district in
//                    District.districtDict = district
//                    
//                    }, onCompleted: { [weak self] in
//                        self?.bindData()
//                        completion()
//                }).disposed(by: rx.disposeBag)
//            return
//        }
//
//        bindData()
//        completion()
    }
}
