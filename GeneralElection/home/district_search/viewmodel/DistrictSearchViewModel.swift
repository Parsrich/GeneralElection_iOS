//
//  DistrictSearchViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import Action
import RxDataSources
import NSObject_Rx

typealias SiSectionModel = AnimatableSectionModel<Int, LocationSi>
typealias GuSectionModel = AnimatableSectionModel<Int, LocationGu>
typealias DongSectionModel = AnimatableSectionModel<Int, LocationDong>

enum LocationType: String {
    case si
    case gu
    case dong
    case selectedDone
}

class DistrictSearchViewModel: BaseViewModel {
    
    var siListObservable: Observable<[SiSectionModel]> {
        return Observable.just([SiSectionModel(model: 0, items: locationSiList)])
    }
    var guListObservable: Observable<[GuSectionModel]> {
        return Observable.just([GuSectionModel(model: 0, items: locationGuList)])
    }
    var dongListObservable: Observable<[DongSectionModel]> {
        return Observable.just([DongSectionModel(model: 0, items: locationDongList)])
    }
    var electionNameObservable: Observable<LocationElectionName> {
        return Observable.just(electionName)
    }
    
    var locationSiList: [LocationSi]
    var locationGuList: [LocationGu]
    var locationDongList: [LocationDong]
    var electionName: LocationElectionName
    
    var locationType: LocationType = .si
    var electionType: ElectionType = .nationalAssembly
    
    let siDataSource: RxTableViewSectionedAnimatedDataSource<SiSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<SiSectionModel>(configureCell: { (dataSource, tableView, indexPath, locationSi) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.className, for: indexPath) as? CityCell else { return UITableViewCell() }
            cell.cityName.text = locationSi.key
            return cell
        })
        
        ds.canEditRowAtIndexPath = { _, _ in return true }
        return ds
    }()
    
    let guDataSource: RxTableViewSectionedAnimatedDataSource<GuSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<GuSectionModel>(configureCell: {(dataSource, tableView, indexPath, locationGu) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.className, for: indexPath) as? CityCell else { return UITableViewCell() }
            cell.cityName.text = locationGu.key
            return cell
        })
        
        ds.canEditRowAtIndexPath = { _, _ in return true }
        return ds
    }()
    
    let dongDataSource: RxTableViewSectionedAnimatedDataSource<DongSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<DongSectionModel>(configureCell: {(dataSource, tableView, indexPath, locationDong) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.className, for: indexPath) as? CityCell else { return UITableViewCell() }
            cell.cityName.text = locationDong.key
            return cell
        })
        
        ds.canEditRowAtIndexPath = { _, _ in return true }
        return ds
    }()
        
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
