//
//  HomeViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMobileAds

class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var noticeButton: UIButton!
    @IBOutlet private weak var partySearchButton: UIButton!
    @IBOutlet private weak var districtSearchButton: UIButton!
    @IBOutlet private weak var candidateSearchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindRx()
    }
    
    func setupUI() {
        setTransparentNavigationController(true)
    }
    
    func bindRx() {
        noticeButton.rx.tap
            .map { 0 }
            .asDriver(onErrorJustReturn: 0)
            .drive(onNext: mainTabBar?.setSelectedIndex(index:))
            .disposed(by: disposeBag)
        
        partySearchButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                FullScreenAdMobManager.share.showAd(from: self)
                if let vc = self.selectViewController(.homeDetail, viewControllerName: PartySearchViewController.className) as? PartySearchViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: disposeBag)
        
        districtSearchButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                FullScreenAdMobManager.share.showAd(from: self)
                if let vc = self.selectViewController(.homeDetail, viewControllerName: DistrictSearchViewController.className) as? DistrictSearchViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: disposeBag)
        
        candidateSearchButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                FullScreenAdMobManager.share.showAd(from: self)
                if let vc = self.selectViewController(.homeDetail, viewControllerName: CandidateSearchViewController.className) as? CandidateSearchViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: disposeBag)
    }
    
    
}


extension HomeViewController: GADInterstitialDelegate {
    /// Tells the delegate an ad request succeeded.
//    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
//      print("interstitialDidReceiveAd")
//    }

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
