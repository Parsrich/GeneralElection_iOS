//
//  DistrictSearchViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import RxDataSources
import NSObject_Rx

enum LocationType: String {
    case si
    case gu
    case dong
    case selectedDone
}

class DistrictSearchViewModel: BaseViewModel {
        
    var locationSiList: [LocationSi]
    var locationGuList: [LocationGu]
    var locationDongList: [LocationDong]
    var electionName: LocationElectionName
    
    var locationType: LocationType = .si
    var electionType: ElectionType = .nationalAssembly
            
    required init() {
        locationSiList = [LocationSi]()
        locationGuList = [LocationGu]()
        locationDongList = [LocationDong]()
        electionName = LocationElectionName(dictionary: nil)
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
    
    func setLocationGuList(selectedIndex: Int) {
        guard let guList = locationSiList[selectedIndex].siValues.first else { return }
        if locationType != .si { return }
        locationGuList.append(contentsOf: guList.value)
    }
    
    func setLocationDongList(selectedIndex: Int) {
        if locationType != .gu { return }
        guard let dongList = locationGuList[selectedIndex].guValues.first else { return }
        
        locationDongList.append(contentsOf: dongList.value)
    }
    
    func setCongress(selectedIndex: Int) {
        if locationType != .dong { return }
        guard let congress = locationDongList[selectedIndex].dongValues.first else { return }
        
        electionName.setValue(electionName: congress.value)
    }
    
    func switchLocationType() {
        switch locationType {
        case .si:
            locationType = .gu
        case .gu:
            locationType = .dong
        case .dong:
            locationType = .selectedDone
        default:
            break
        }
    }
    
    func switchElectionType(electionType: ElectionType) {
        self.electionType = electionType
    }
}
