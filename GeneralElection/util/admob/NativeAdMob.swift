//
//  NativeAdMob.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/05.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import GoogleMobileAds
import RxSwift

enum AdType {
    case candidate
    case search
    case party
}
class NativeAdMobManager: NSObject {
    
    static let share = NativeAdMobManager()
    var candidateAdLoader: GADAdLoader?
    var searchAdLoader: GADAdLoader?
    var partyAdLoader: GADAdLoader?

    #if DEBUG // 네이티브 테스트
    let candidateAdUnitId = "ca-app-pub-3940256099942544/3986624511"
    let searchAdUnitId = "ca-app-pub-3940256099942544/3986624511"
    let partyAdUnitId = "ca-app-pub-3940256099942544/3986624511"
    #else   // 네이티브 광고 ID
    let candidateAdUnitId =  FirebaseManager.share.stringValue(key: .candidateListAdId, defaultValue: "ca-app-pub-6176394344908792/5156701876")
    let searchAdUnitId = FirebaseManager.share.stringValue(key: .searchAdId, defaultValue: "ca-app-pub-6176394344908792/3177228180")
    let partyAdUnitId = "ca-app-pub-6176394344908792/6924901505"
    #endif
    
    func createAd(delegate: GADAdLoaderDelegate, viewController: UIViewController, type: AdType) {
        
        switch type {
        case .candidate:
            
            
            candidateAdLoader = GADAdLoader(adUnitID: candidateAdUnitId,
                rootViewController: viewController,
                adTypes: [ .unifiedNative ],
                options: nil)
            candidateAdLoader?.delegate = delegate
        case .search:
            searchAdLoader = GADAdLoader(adUnitID: searchAdUnitId,
                rootViewController: viewController,
                adTypes: [ .unifiedNative ],
                options: nil)
            searchAdLoader?.delegate = delegate
        case .party:
            partyAdLoader = GADAdLoader(adUnitID: partyAdUnitId,
                rootViewController: viewController,
                adTypes: [ .unifiedNative ],
                options: nil)
            partyAdLoader?.delegate = delegate
            
        }
    }
    
    func showAd(type: AdType) {
        switch type {
        case .candidate:
            candidateAdLoader?.load(GADRequest())
        case .search:
            searchAdLoader?.load(GADRequest())
        case .party:
            partyAdLoader?.load(GADRequest())
        }
    }
}
