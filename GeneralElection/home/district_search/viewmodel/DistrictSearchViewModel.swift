//
//  DistrictSearchViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import NSObject_Rx

class DistrictSearchViewModel: BaseViewModel {
    
    var locationSiList: [LocationSi]
        
    required init() {
        locationSiList = [LocationSi]()
        super.init()
    }
    
    func fetchDistrictKeys(location: String? = nil, completion: @escaping () -> Void) {
        if locationSiList.isEmpty {
            FirebaseHelper.fetchDatas(path: .district, location: location)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.asyncInstance)
                .subscribe(onNext: { district in
                    District.districtDict = district
                    
                    }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                }).disposed(by: rx.disposeBag)
            return
        }
        
        completion()
    }
    
    func bindData() {
        setLocationData()
    }
    
    func setLocationData() {
        
        guard let data = District.districtDict,
            let keys = data.allKeys as? [String] else { return }
        
        for key in keys {
            guard let values = data.value(forKey: key) as? NSDictionary
                else { continue }
            locationSiList.append(LocationSi(siName: key, guList: values))
        }
    }
}
