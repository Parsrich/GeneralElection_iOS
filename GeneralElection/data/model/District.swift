//
//  District.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/21.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation
import RxDataSources

struct District {
    static var districtDict: NSDictionary?
}

struct LocationSi: Equatable, IdentifiableType {
    var identity: String
    var siValues: [String: [LocationGu]]
    
    var key: String {
        guard let key = self.siValues.keys.first else { return "" }
        return key
    }
    
    init(siName: String, guList: NSDictionary?) {
        siValues = [String: [LocationGu]]()
        identity = siName
        guard let data = guList,
            let keys = data.allKeys as? [String] else { return }
        
        var locationGuList = [LocationGu]()
        for key in keys {
            guard let values = data.value(forKey: key) as? NSDictionary
                else { continue }
            let gu = LocationGu(guName: key, dongList: values)
            locationGuList.append(gu)
        }
        
        siValues[siName] = locationGuList
    }
    
    static func == (lhs: LocationSi, rhs: LocationSi) -> Bool {
        return lhs.key == rhs.key
    }
}

class LocationGu: Equatable, IdentifiableType {
    var identity: String
    var guValues: [String: [LocationDong]]
    
    var key: String {
        guard let key = self.guValues.keys.first else { return "" }
        return key
    }
    
    init(guName: String, dongList: NSDictionary?) {
        guValues = [String: [LocationDong]]()
        identity = guName
        guard let data = dongList,
            let keys = data.allKeys as? [String] else { return }
        
        var locationDongList = [LocationDong]()
        for key in keys {
            guard let values = data.value(forKey: key) as? NSDictionary
                else { continue }
            let dong = LocationDong(dongName: key, locationElectionName: values)
            locationDongList.append(dong)
        }
        
        guValues[guName] = locationDongList
    }
    
    static func == (lhs: LocationGu, rhs: LocationGu) -> Bool {
        return lhs.key == rhs.key
    }
}

class LocationDong: Equatable, IdentifiableType {
    var identity: String
    var dongValues: [String: LocationElectionName]
    
    var key: String {
        guard let key = self.dongValues.keys.first else { return "" }
        return key
    }
    
    init(dongName: String, locationElectionName: NSDictionary?) {
        dongValues = [String: LocationElectionName]()
        identity = dongName
        guard let data = locationElectionName else { return }
        
        dongValues[dongName] = LocationElectionName(dictionary: data)
    }
    
    static func == (lhs: LocationDong, rhs: LocationDong) -> Bool {
        return lhs.key == rhs.key
    }
}

class LocationElectionName {
    
    var congress: String
//    var siMayor: String
    var guMayor: String
    var siCouncil: String
    var guCouncil: String
    
    init(dictionary: NSDictionary?) {
        self.congress = (dictionary?["congress"] as? String) ?? ""
        self.guMayor = (dictionary?["guMayor"] as? String) ?? ""
        self.siCouncil = (dictionary?["siCouncil"] as? String) ?? ""
        self.guCouncil = (dictionary?["guCouncil"] as? String) ?? ""
    }
    
    func setValue(electionName: LocationElectionName) {
        self.congress = electionName.congress
        self.guMayor = electionName.guMayor
        self.siCouncil = electionName.siCouncil
        self.guCouncil = electionName.guCouncil
    }
}
