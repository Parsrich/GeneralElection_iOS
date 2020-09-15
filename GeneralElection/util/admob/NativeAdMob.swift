//
//  NativeAdMob.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/05.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import GoogleMobileAds

class NativeAdMobManager: NSObject {
    
    static let share = NativeAdMobManager()
    var adLoader: GADAdLoader?
    
    #if DEBUG
    let adUnitId = "ca-app-pub-3940256099942544/3986624511"
    #else
    let adUnitId = "ca-app-pub-6176394344908792/1135650097"
    #endif
    
    func createAd(delegate: GADAdLoaderDelegate, viewController: UIViewController) {
        adLoader = GADAdLoader(adUnitID: adUnitId,
            rootViewController: viewController,
            adTypes: [ .unifiedNative ],
            options: nil)
        adLoader?.delegate = delegate
    }
    
    func showAd() {
        adLoader?.load(GADRequest())
    }
}
