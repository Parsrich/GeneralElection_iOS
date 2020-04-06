//
//  FullScreenAdMob.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/05.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import GoogleMobileAds

class FullScreenAdMobManager: NSObject {
    
    static let share = FullScreenAdMobManager()
    var interstitial: GADInterstitial?
    var delegate: GADInterstitialDelegate?
    var count = 0
    
    #if DEBUG   // 전면 테스트
    let adUnitId = "ca-app-pub-3940256099942544/4411468910"
    #else   // 전면 광고 ID
    let adUnitId = FirebaseManager.share.stringValue(key: .fullAdId, defaultValue: "ca-app-pub-6176394344908792/1135650097")
    #endif
    
    func createAd() {
        let interstitial = GADInterstitial(adUnitID: adUnitId)
        
        self.interstitial = interstitial
        
        self.interstitial?.delegate = self.delegate
        self.interstitial?.load(GADRequest())
    }
    
    func renewAd() {
        createAd()
    }
    
    func showAd(from fromRootViewController: UIViewController) {
        if interstitial?.isReady == true {
            interstitial?.present(fromRootViewController: fromRootViewController)
        } else {
            if count == 5 {
                renewAd()
                count = 0
                return
            }
            count += 1
        }
    }
}
