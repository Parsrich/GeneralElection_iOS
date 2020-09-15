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
import GoogleMobileAds

class SplashViewController: BaseViewController {
    
    var remoteConfig: RemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFirebase()
        
        googleAdMob()
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
            if !isComplete {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.performSegue(withIdentifier: "main", sender: self)
                }
                return
                
            }
            
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
    
    func googleAdMob() {
        FullScreenAdMobManager.share.delegate = self
        FullScreenAdMobManager.share.createAd()
    }
}

extension SplashViewController: GADInterstitialDelegate {
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      print("interstitialDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
      print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      print("interstitialWillPresentScreen")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("interstitialWillDismissScreen")
    }

    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      print("interstitialDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("interstitialWillLeaveApplication")
    }
}
