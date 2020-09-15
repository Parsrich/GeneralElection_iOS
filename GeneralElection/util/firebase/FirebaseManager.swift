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

enum DatabasePath: String {
    case root = "/"
    case partyPromise = "/partyPromise"
    case congress = "/congress"
    case district = "/district"
    case guCouncil = "/guCouncil"
    case guMayor = "/guMayor"
    case siCouncil = "/siCouncil"
    case candidateName = "/name"
    case proportional = "/proportional"
    case location = "/location"
}

class FirebaseManager {
    static let share = FirebaseManager()
    
    var remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()
    #if DEBUG
    let expirationDutation:TimeInterval = 0
    #else
    let expirationDutation:TimeInterval = 43200
    #endif
    
    private init() {
        
        initRemoteConfig()
    }
    
    /// # Firebase Realtime DB
    func firebaseDB(path: DatabasePath) -> DatabaseReference  {
        return Database.database().reference(withPath: path.rawValue)
    }
    
    /// # Firebase RemoteConfig
    func initRemoteConfig() {
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = expirationDutation
        remoteConfig.configSettings = settings
        // [END enable_dev_mode]
        // Set default Remote Config parameter values. An app uses the in-app default values, and
        // when you need to adjust those defaults, you set an updated value for only the values you
        // want to change in the Firebase console. See Best Practices in the README for more
        // information.
        // [START set_default_values]
//        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
    }
    
    func setRemoteConfigDefaults(defaults: [String : NSObject]) {
        self.remoteConfig.setDefaults(defaults)
    }

    func setRemoteConfigDefaults(fromPlist plist: String) {
        self.remoteConfig.setDefaults(fromPlist: plist)
    }

    func fetch(completion: @escaping ((Bool)->())) {
        self.remoteConfig.fetch(withExpirationDuration: expirationDutation) { (status, error) in
            if status == .success {
              print("Config fetched!")
              self.remoteConfig.activate(completionHandler: { (error) in
                completion(true)
              })
            } else {
              print("Config not fetched")
              print("Error: \(error?.localizedDescription ?? "No error available.")")
              completion(false)
            }
        }
        
//        self.remoteConfig.fetchAndActivate { (status, error) in
//            switch status {
//            case .successFetchedFromRemote: fallthrough
//            case .successUsingPreFetchedData:
//                // ReadME!!!!. 항상 firebase 관련 로직은 activateFetched 이후에 진행 할 것.
//                completion(true)
//
//            case .error:
//                if let error = (error as NSError?) {
//                    print(error)
//                }
//
//                completion(false)
//
//            @unknown default:
//                completion(false)
//            }
//        }
    }
}
//
extension FirebaseManager {
//    func intValue(key: RemoteConfigKey) -> Int {
//        if let number = self.remoteConfig.configValue(forKey: key.rawValue).numberValue {
//            return number.intValue
//
//        } else {
//            return 0
//        }
//    }
//
    func stringValue(key: RemoteConfigKey) -> String {
        return remoteConfig.configValue(forKey: key.rawValue).stringValue ?? ""
    }
//
//    func boolValue(key: RemoteConfigKey) -> Bool {
//        return remoteConfig.configValue(forKey: key.rawValue).boolValue
//    }
//
//    func typeValue<T>(key: RemoteConfigKey, type: T.Type) -> T? {
//        let data = self.remoteConfig.configValue(forKey: key.rawValue).dataValue
//        do {
//            return try JSONSerialization.jsonObject(with: data, options: []) as? T
//
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//
//    func typeValue<T : Codable>(key: RemoteConfigKey, type: T.Type) -> T? {
//        let data = self.remoteConfig.configValue(forKey: key.rawValue).dataValue
//        do {
//            return try JSONDecoder().decode(T.self, from: data)
////            return try JSONDecoder.decode(data, to: type)
//
//        } catch {
//            print(error)
//            return nil
//        }
//    }
}
