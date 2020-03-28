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
        if District.districtDict == nil {
            FirebaseHelper.fetchDatas(path: .district, key: location)
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
        locationGuList.removeAll()
        locationGuList.append(contentsOf: guList.value)
        locationGuList.sort { $0.key < $1.key }
    }
    
    func setLocationDongList(selectedIndex: Int) {
        if locationType != .gu { return }
        guard let dongList = locationGuList[selectedIndex].guValues.first else { return }
        locationDongList.removeAll()
        locationDongList.append(contentsOf: dongList.value)
        locationDongList.sort { $0.key < $1.key }
    }
    
    func setCongress(selectedIndex: Int) {
        if locationType != .dong { return }
        guard let congress = locationDongList[selectedIndex].dongValues.first else { return }
        
        electionName.setValue(electionName: congress.value)
    }
    
    /// # 지역 누르면 현재 보여지는 TableView의 지역 단위를 설정해줌
    /// ## Parameters
    /// - isBack: 상위 지역을 선택해야할 경우 true, 하위로 가면 false
    func switchLocationType(_ locationType: LocationType) {
        self.locationType = locationType
//        switch self.locationType {
//        case .si:
//            if isBack { break }
//            locationType = .gu
//        case .gu:
//            if isBack {
//                locationType = .si
//                break
//            }
//            locationType = .dong
//        case .dong:
//            if isBack {
//                locationType = .gu
//                break
//            }
//            locationType = .selectedDone
//        case .selectedDone:
//            if isBack {
//                locationType = .dong
//            }
//        }
    }
    
    func switchElectionType(electionType: ElectionType) {
        self.electionType = electionType
    }
}
