//
//  FirebaseManager.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/19.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirebaseManager {
    static let share = FirebaseManager()
    var remoteConfig:RemoteConfig = RemoteConfig.remoteConfig()
    #if DEBUG
    let expirationDutation:TimeInterval = 0
    #else
    let expirationDutation:TimeInterval = 3000
    #endif
    
    
    func firebaseDB(path:DatabasePath) -> DatabaseReference  {
        return Database.database().reference(withPath: path.rawValue)
    }
    private init() {
//        // This no longer needs to be set during development. Refer to documentation for additional details. 07.10 by hysia
//        #if DEBUG
//            self.remoteConfig.configSettings = RemoteConfigSettings.init(developerModeEnabled: true)
//        #endif
    }
    
    func setRemoteConfigDefaults(defaults:[String : NSObject]) {
        self.remoteConfig.setDefaults(defaults)
    }
    
    func setRemoteConfigDefaults(fromPlist plist:String) {
        self.remoteConfig.setDefaults(fromPlist: plist)
    }
    
    func fetch(completion:@escaping ((Bool)->())) {
        self.remoteConfig.fetchAndActivate { (status, error) in
            switch status {
            case .successFetchedFromRemote: fallthrough
            case .successUsingPreFetchedData:
                // ReadME!!!!. 항상 firebase 관련 로직은 activateFetched 이후에 진행 할 것.
                NetworkDefine.share.update()
                completion(true)
                
            case .error:
                if let error = (error as NSError?) {
                    print(error)
                }
                
                completion(false)
                
            @unknown default:
                completion(false)
            }
        }
//        self.remoteConfig.fetch(withExpirationDuration: expirationDutation) { (status, error) in
//            if let error = error {
//                completion(false)
//                #if DEBUG
//                    print(error)
//                #endif
//            } else {
//                self.remoteConfig.activate(completionHandler: { (error) in
//                    if let error = (error as NSError?) {
//                        print(error)
//                        completion(false)
//                        return
//                    }
//
//                    // ReadME!!!!. 항상 firebase 관련 로직은 activateFetched 이후에 진행 할 것.
//                    NetworkDefine.share.update()
//                    completion(true)
//                })
//
//            }
//        }
    }
    
    func firebaseDB(path:DatabasePath) -> DatabaseReference  {
        return Database.database().reference(withPath: path.rawValue)
    }
}

extension FirebaseManager {
    func intValue(key: RemoteConfigKey) -> Int {
        if let number = self.remoteConfig.configValue(forKey: key.rawValue).numberValue {
            return number.intValue
            
        } else {
            return 0
        }
    }
    
    func stringValue(key: RemoteConfigKey) -> String {
        return remoteConfig.configValue(forKey: key.rawValue).stringValue ?? ""
    }
    
    func boolValue(key: RemoteConfigKey) -> Bool {
        return remoteConfig.configValue(forKey: key.rawValue).boolValue
    }
    
    func typeValue<T>(key: RemoteConfigKey, type: T.Type) -> T? {
        let data = self.remoteConfig.configValue(forKey: key.rawValue).dataValue
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? T
            
        } catch {
            print(error)
            return nil
        }
    }
    
    func typeValue<T : Codable>(key: RemoteConfigKey, type: T.Type) -> T? {
        let data = self.remoteConfig.configValue(forKey: key.rawValue).dataValue
        do {
            return try JSONDecoder().decode(T.self, from: data)
//            return try JSONDecoder.decode(data, to: type)
            
        } catch {
            print(error)
            return nil
        }
    }
}
