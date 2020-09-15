//
//  AdPartyCell.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/05.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import GoogleMobileAds
import RxSwift

class AdPartyCell: UICollectionViewCell {
//    
//    @IBOutlet weak var nativeAdView: GADUnifiedNativeAdView!
//    //    @IBOutlet weak var mediaView: GADMediaView!
//    @IBOutlet weak var headlineLabel: UILabel!
//    @IBOutlet weak var thumbnailImageView: UIImageView!
//    @IBOutlet weak var advertisementLabel: UILabel!
//    @IBOutlet weak var adImageView: UIImageView!
//    @IBOutlet weak var contentLabel: UILabel!
//    @IBOutlet weak var storeLabel: UILabel!
//    @IBOutlet weak var installButton: UIButton!
//    @IBOutlet weak var adMarkLabel: UILabel!
//    
//    @IBOutlet weak var adViewHeightConstraint: NSLayoutConstraint!
//    var setupFlag = true
//    private var heightSubject = BehaviorSubject<CGFloat>(value: 0)
//    var heightObservable: Observable<CGFloat> {
//        return heightSubject.asObservable()
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        
//        //        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
//        //
//        //        let constraint = nativeAdView.heightAnchor.constraint(equalToConstant: 130)
//        //        NSLayoutConstraint.activate([
//        //          nativeAdView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
//        //          nativeAdView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
//        //          nativeAdView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
//        //          nativeAdView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
//        //          constraint
//        //        ])
//    }
//    
//    func viewBinding() {
//        //        nativeAdView = adView
//        //        nativeAdContinerView.addSubViewWithFullAutoLayout(subview: nativeAdView!)
//    }
//    
//}
//
//
//extension AdCandidateCell: GADUnifiedNativeAdDelegate {
//    func nativeAdDidRecordImpression(_ nativeAd: GADUnifiedNativeAd) {
//        // The native ad was shown.
//    }
//    
//    func nativeAdDidRecordClick(_ nativeAd: GADUnifiedNativeAd) {
//        // The native ad was clicked on.
//    }
//    
//    func nativeAdWillPresentScreen(_ nativeAd: GADUnifiedNativeAd) {
//        // The native ad will present a full screen view.
//    }
//    
//    func nativeAdWillDismissScreen(_ nativeAd: GADUnifiedNativeAd) {
//        // The native ad will dismiss a full screen view.
//    }
//    
//    func nativeAdDidDismissScreen(_ nativeAd: GADUnifiedNativeAd) {
//        // The native ad did dismiss a full screen view.
//    }
//    
//    func nativeAdWillLeaveApplication(_ nativeAd: GADUnifiedNativeAd) {
//        // The native ad will cause the application to become inactive and
//        // open a new application.
//    }
//}
//
//extension AdCandidateCell: GADAdLoaderDelegate {
//    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
//        nativeAdView?.isHidden = true
//        adMarkLabel.isHidden = true
//        print("\(adLoader) failed with error: \(error.localizedDescription)")
//        self.heightSubject.onNext(0)
//    }
//}
//
//extension AdCandidateCell: GADVideoControllerDelegate {
//    
//    func videoControllerDidEndVideoPlayback(_ videoController: GADVideoController) {
//        //        videoStatusLabel.text = "Video playback has ended."
//    }
//}
//
//extension AdCandidateCell: GADUnifiedNativeAdLoaderDelegate {
//    
//    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
//        nativeAdView?.isHidden = false
//        adMarkLabel.isHidden = false
//        self.heightSubject.onNext(130)
//        
//        nativeAdView?.nativeAd = nativeAd
//        
//        print("headline: \(nativeAd.headline ?? "")")
//        // Set ourselves as the native ad delegate to be notified of native ad events.
//        nativeAd.delegate = self
//        
//        // Deactivate the height constraint that was set when the previous video ad loaded.
//        //        heightConstraint?.isActive = false
//        
//        // Populate the native ad view with the native ad assets.
//        // The headline and mediaContent are guaranteed to be present in every native ad.
//        headlineLabel?.text = nativeAd.headline
//        
//        
//        //        ////// video
//        //        mediaView?.mediaContent = nativeAd.mediaContent
//        //
//        //        // Some native ads will include a video asset, while others do not. Apps can use the
//        //        // GADVideoController's hasVideoContent property to determine if one is present, and adjust their
//        //        // UI accordingly.
//        //        let mediaContent = nativeAd.mediaContent
//        //        if mediaContent.hasVideoContent {
//        //            // By acting as the delegate to the GADVideoController, this ViewController receives messages
//        //            // about events in the video lifecycle.
//        //            mediaContent.videoController.delegate = self
//        //            print("Ad contains a video asset.")
//        //        }
//        //        else {
//        //            print("Ad does not contain a video.")
//        //        }
//        //        ////// video
//        
//        // These assets are not guaranteed to be present. Check that they are before
//        // showing or hiding them.
//        contentLabel?.text = nativeAd.body
//        contentLabel?.isHidden = nativeAd.body == nil
//        
//        installButton?.setTitle(nativeAd.callToAction, for: .normal)
//        installButton?.isHidden = nativeAd.callToAction == nil
//        
//        nativeAd.enableCustomClickGestures()
//        nativeAd.registerClickConfirmingView(installButton)
//        thumbnailImageView?.image = nativeAd.icon?.image
//        thumbnailImageView?.isHidden = nativeAd.icon == nil
//        
//        //        nativeAdView?.starRatingView?.isHidden = nativeAd.starRating == nil
//        
//        storeLabel?.text = nativeAd.store
//        storeLabel?.isHidden = nativeAd.store == nil
//        
//        //        (nativeAdView?.priceView as? UILabel)?.text = nativeAd.price
//        //        nativeAdView?.priceView?.isHidden = nativeAd.price == nil
//        
//        advertisementLabel?.text = nativeAd.advertiser
//        advertisementLabel?.isHidden = nativeAd.advertiser == nil
//        
//        // In order for the SDK to process touch events properly, user interaction should be disabled.
//        installButton?.isUserInteractionEnabled = false
//        
//    }
}
