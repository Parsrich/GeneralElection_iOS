//
//  CandidateSearchViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxKeyboard

class CandidateSearchViewController: BaseViewControllerWithViewModel<CandidateSearchViewModel> {
    
    @IBOutlet weak var searchFieldBorderView: UIView!
    @IBOutlet weak var candidateSearchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultToBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var nameResultTableView: UITableView!
    @IBOutlet weak var resultViewBackView: UIView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var adContainerView: UIView!
    
    var nativeAdView: GADTSmallTemplateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        candidateSearchField.delegate = self
        setupUI()
        bindRx()

        
        nativeAdView = GADTSmallTemplateView(frame: adContainerView.frame)
        adContainerView.addSubViewWithFullAutoLayout(subview: nativeAdView)
        adContainerView.isHidden = true
        
        NativeAdMobManager.share.createAd(delegate: self, viewController: self, type: .search)
        NativeAdMobManager.share.showAd(type: .search)
    }
    
    func setupUI() {
        setTransparentNavigationController(false)
        setShadowViewUnderNavigationController()
        searchFieldBorderView.layer.borderWidth = 2
        searchFieldBorderView.layer.borderColor = UIColor(red: 127.toRgb,
                                                          green: 111.toRgb,
                                                          blue: 237.toRgb,
                                                          alpha: 1.0).cgColor

        candidateSearchField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
        adContainerView.layer.borderWidth = 1
        adContainerView.layer.borderColor = UIColor.lightGray.cgColor
        
        if view.topSafeAreaInset == 20 {
            self.topConstraint.constant = self.topConstraint.constant - 20
            view.layoutIfNeeded()
        }
    }
    
    func bindRx() {
        searchButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
//                self.candidateSearchField.text
                // 검색 결과가 2이상이면
                self.nextViewController(name: self.candidateSearchField.text ?? "")
            }).disposed(by: rx.disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] height in
                guard let `self` = self else { return }
                UIView.animate(withDuration: 0.3) {
                    self.topConstraint.constant =
                    height == 0 ?
                        height :  (self.view.safeAreaInsets.bottom) - height
                    self.resultToBottomContraint.constant =
                        height == 0 ?
                            height : height - (self.view.safeAreaInsets.bottom)
                    self.view.layoutIfNeeded()
                    
                    self.backgroundImageView.alpha = height == 0 ? 1.0 : 0.0
                }
            }).disposed(by: rx.disposeBag)
    }
    
    func nextViewController(name: String) {
        
        let candidates = CandidateMemory.candidateDataList(keyword: name)
        
        if candidates.count > 1 {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: CandidateSearchListResultViewController.className) as? CandidateSearchListResultViewController {

                vc.sourceResult = .candidateSearch
                vc.candidates = candidates
                
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if candidates.count == 1 {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: CandidateSearchResultViewController.className) as? CandidateSearchResultViewController {

                vc.sourceResult = .candidateSearch
                vc.candidate = candidates.first
                
                if candidates.first?.status == "resign" {
                    showAlert(alertTitle: "사퇴한 후보자입니다.", alertMessage: "")
                    return
                }
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func showAlert(alertTitle title: String, alertMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension CandidateSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func textChanged(_ textField: UITextField) {
        
        resultViewBackView.isHidden = textField.text == ""
        viewModel!.showKeywordList(keyword: textField.text ?? "")
        nameResultTableView.reloadData()
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let text = self.candidateSearchField.text {
//
//            let whipeSpaceRemovedText = text.replacingOccurrences(of: " ", with: "")
//
//            self.candidateSearchField.text = whipeSpaceRemovedText
//
//        }
//    }
}

extension CandidateSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.candidateNameList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CandidateNameCell.className, for: indexPath) as? CandidateNameCell else { return UITableViewCell() }
        cell.nameLabel.text = viewModel!.candidateNameList?[indexPath.row]
        return cell
    }
}

extension CandidateSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        guard let name = viewModel!.candidateNameList?[indexPath.row] else { return }
        
        nextViewController(name: name)
    }
}

extension CandidateSearchViewController: GADUnifiedNativeAdDelegate {
    public func nativeAdDidRecordImpression(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad was shown.
    }
    
    public func nativeAdDidRecordClick(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad was clicked on.
    }
    
    public func nativeAdWillPresentScreen(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad will present a full screen view.
    }
    
    public func nativeAdWillDismissScreen(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad will dismiss a full screen view.
    }
    
    public func nativeAdDidDismissScreen(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad did dismiss a full screen view.
    }
    
    public func nativeAdWillLeaveApplication(_ nativeAd: GADUnifiedNativeAd) {
        // The native ad will cause the application to become inactive and
        // open a new application.
    }
}

extension CandidateSearchViewController: GADUnifiedNativeAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        print("\(adLoader) failed with error: \(error.localizedDescription)")
        adContainerView.isHidden = true
    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        print("\(adLoader) didReceived")
        adContainerView.isHidden = false
        nativeAdView.nativeAd = nativeAd
        nativeAd.delegate = self
        // Associate the native ad view with the native ad object. This is
        // required to make the ad clickable.
        nativeAdView.nativeAd = nativeAd

        // Populate the native ad view with the native ad assets.
        // The headline is guaranteed to be present in every native ad.
        (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline

        // These assets are not guaranteed to be present. Check that they are before
        // showing or hiding them.
        (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
        nativeAdView.bodyView?.isHidden = nativeAd.body == nil

        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil

        (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        nativeAdView.iconView?.isHidden = nativeAd.icon == nil

        nativeAdView.starRatingView?.isHidden = true

        (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
        nativeAdView.storeView?.isHidden = nativeAd.store == nil

        (nativeAdView.priceView as? UILabel)?.text = nativeAd.price
        nativeAdView.priceView?.isHidden = nativeAd.price == nil

        (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
        nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil

        // In order for the SDK to process touch events properly, user interaction
        // should be disabled.
        nativeAdView.callToActionView?.isUserInteractionEnabled = false
    }
}
