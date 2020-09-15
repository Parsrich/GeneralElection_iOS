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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        candidateSearchField.delegate = self
        setupUI()
        bindRx()

        if let adView = AdCandidateSearchView.instanceFromNib() {
            adContainerView.addSubViewWithFullAutoLayout(subview: adView)
            NativeAdMobManager.share.createAd(delegate: adView, viewController: self, type: .search)
            NativeAdMobManager.share.showAd(type: .search)
        }
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
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
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
