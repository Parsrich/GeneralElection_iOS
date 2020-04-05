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
    
    #if DEBUG
    let adUnitId = "ca-app-pub-3940256099942544/3986624511"
    #else
    let adUnitId = "ca-app-pub-6176394344908792/5156701876"
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
            renewAd()
        }
    }
}
