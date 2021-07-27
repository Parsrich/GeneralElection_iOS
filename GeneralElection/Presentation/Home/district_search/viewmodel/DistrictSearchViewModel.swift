//
//  DistrictSearchViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import RxDataSources


enum ElectionType: String {
    case nationalAssembly = "국회의원선거"
    case siMayor = "시∙도의 장선거"
    case guMayor = "구∙시∙군의 장선거"
    case siCouncil = "시∙도의회의원선거"
    case guCouncil = "구∙시∙군의회의원선거"
}

enum LocationType: String {
    case si
    case gu
    case dong
    case selectedDone
}

class DistrictSearchViewModel: BaseViewModel {
        
    var currentDistrict: [String]
    
    var locationSiList: [LocationSi]
    var locationGuList: [LocationGu]
    var locationDongList: [LocationDong]
    var electionName: LocationElectionName
    
    var locationType: LocationType = .si
    var electionType: ElectionType = .nationalAssembly
            
    override init() {
        currentDistrict = [String]()
        locationSiList = [LocationSi]()
        locationGuList = [LocationGu]()
        locationDongList = [LocationDong]()
        electionName = LocationElectionName(dictionary: nil)
        super.init()
    }
    
    func fetchDistrictKeys(location: String? = nil, errorHandler: @escaping (Error) -> Void, completion: @escaping () -> Void) {
        if District.districtDict == nil {
            FirebaseHelper.fetchDatas(path: .district, key: location)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.asyncInstance)
                .subscribe(onNext: { district in
                    District.districtDict = district
                    
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
        setLocationSiList()
    }
    
    func setLocationSiList() {
        
        guard let data = District.districtDict,
            let keys = data.allKeys as? [String] else { return }
        
        locationSiList.removeAll()
        
        for key in keys {
            guard let values = data.value(forKey: key) as? NSDictionary
                else { continue }
            locationSiList.append(LocationSi(siName: key, guList: values))
        }
        locationSiList.sort { $0.key < $1.key }
    }
    
    func setLocationGuList(selectedIndex: Int) {
        if locationType != .si { return }
        guard let guList = locationSiList[selectedIndex].siValues.first else { return }
        currentDistrict.append(locationSiList[selectedIndex].key)
        locationGuList.removeAll()
        locationGuList.append(contentsOf: guList.value)
        locationGuList.sort { $0.key < $1.key }
    }
    
    func setLocationDongList(selectedIndex: Int) {
        if locationType != .gu { return }
        guard let dongList = locationGuList[selectedIndex].guValues.first else { return }
        currentDistrict.append(locationGuList[selectedIndex].key)
        locationDongList.removeAll()
        locationDongList.append(contentsOf: dongList.value)
        locationDongList.sort { $0.key < $1.key }
    }
    
    func setCongress(selectedIndex: Int) {
        if locationType != .dong { return }
        guard let congress = locationDongList[selectedIndex].dongValues.first else { return }
        if currentDistrict.count > 0 {
            electionName.setValue(electionName: congress.value, siName: currentDistrict[0])
        }
    }
    
    /// # 지역 누르면 현재 보여지는 TableView의 지역 단위를 설정해줌
    func switchLocationType(_ locationType: LocationType) {
        self.locationType = locationType
    }
    
    func switchElectionType(electionType: ElectionType) {
        self.electionType = electionType
    }
}
