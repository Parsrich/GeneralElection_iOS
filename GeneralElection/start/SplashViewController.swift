//
//  SplashViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import Firebase
import RxSwift

class SplashViewController: BaseViewController {
    
    var remoteConfig: RemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFirebase()
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
//        }
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
        
        FirebaseManager.share.fetch {  [weak self] isComplete in
            guard let `self` = self else { return }
            if !isComplete { return }
            
            /// 새로운 버전 체크
            let fetchedAppVersion = FirebaseManager.share.stringValue(key: .appVersion)
            if fetchedAppVersion != Config.appVersion {

                DispatchQueue.main.async {
                    let vc = self.showConfirmationAlert(alertTitle: "앱이 업데이트 되었습니다.", alertMessage: "새로운 앱으로 업데이트를 하기 위해 앱스토어로 이동합니다.")
                    self.present(vc, animated: true)
                }
                
                /// Go To Appstore
                if let url = URL(string: FirebaseManager.share.stringValue(key: .appStoreUrl)) {
                    UIApplication.shared.open(url)
                }
                return
            }

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.performSegue(withIdentifier: "main", sender: self)
            }
            
        }

    }
}
