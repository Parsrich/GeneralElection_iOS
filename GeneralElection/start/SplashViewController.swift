//
//  SplashViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
    
    var remoteConfig: RemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setFirebase()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            self?.performSegue(withIdentifier: "main", sender: self)
        }
    }
    
    func setFirebase() {
        
        remoteConfig = RemoteConfig.remoteConfig()

        let settings = RemoteConfigSettings()
        #if DEBUG
        settings.minimumFetchInterval = 0
        #else
        settings.minimumFetchInterval = 3000
        #endif
        remoteConfig.configSettings = settings
        
        FirebaseManager.share.fetch { isComplete in
            if !isComplete { return }
            
            /// 새로운 버전 체크
            let fetchedAppVersion = FirebaseManager.share.stringValue(key: .appVersion)
            if fetchedAppVersion != Config.appVersion {
                /// Go To Appstore
                if let url = URL(string: FirebaseManager.share.stringValue(key: .appStoreUrl)) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}
