//
//  CandidateSearchListResultViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/25.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import GoogleMobileAds

class CandidateSearchListResultViewController: BaseViewControllerWithViewModel<CandidateSearchListResultViewModel> {
    
    @IBOutlet weak var mapIconView: UIImageView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var candidateTableView: UITableView!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var emptyView: UIImageView!
    @IBOutlet weak var buttonClickLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    
    @IBOutlet weak var proportionalLabel: UILabel!
    @IBOutlet weak var candidateViewTopContraint: NSLayoutConstraint!
    var adHeight: CGFloat = 0.0
    var adFlag = true
    
    var electionType: ElectionType?
    var electionName: LocationElectionName?
    var districtString: String?
    
    var sourceResult: SourceResult?
    var candidates: [Candidate]?
    var partyName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
//        Congress.reset()
        if let type = electionType, let name = electionName, let districtString = districtString {
            viewModel!.electionType = type
            viewModel!.electionName = name
            viewModel!.districtString = districtString
        }
        
        if let candidates = candidates {
            viewModel!.congressCandidateList.removeAll()
            viewModel!.congressCandidateList = candidates.sorted { Int($0.recommend ?? "0") ?? 0 < Int($1.recommend ?? "0") ?? 0 }
        }
        if let districtString = districtString {
            viewModel!.districtString = districtString
        }
        
        setupUI()
        bindRx()
        setup()
    }
    
    func setup() {
        guard let source = self.sourceResult else { return }
        switch source {
        case .districtSearch:
            fetchCandidates()
        case .candidateSearch:
            districtLabel.isHidden = false
            proportionalLabel.isHidden = true
            districtLabel.text = "\(candidates?.first?.name ?? "")에 대한 검색 결과입니다."
            fallthrough
        case .partySearch:
            candidateViewTopContraint.priority = UILayoutPriority.defaultHigh
            
            locationLabel.isHidden = true
            buttonClickLabel.isHidden = true
            categoryView.isHidden = true
            
            candidateTableView.reloadData()
        }
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
        locationLabel.text = viewModel!.electionName.getElectionName(electionType: viewModel!.electionType).replacingOccurrences(of: "_", with: " ")
        
        if let source = sourceResult {
            switch source {
            case .districtSearch:
                emptyView.isHidden = !viewModel!.electionName.isEmpty
            case .candidateSearch, .partySearch:
                districtLabel.isHidden = true
                mapIconView.isHidden = true
                proportionalLabel.isHidden = false
                emptyView.isHidden = (candidates?.count ?? 0) != 0
//            case .candidateSearch:
//                districtLabelLeadingConstraint.priority = .defaultHigh
//                emptyView.isHidden = (candidates?.count ?? 0) != 0
//                mapIconView.isHidden = true
            }
        }
        
        categoryButton.setTitle(viewModel!.electionType.rawValue, for: .normal)
        
        districtLabel.text = districtString
        
//        candidateTableView.rowHeight = UITableView.automaticDimension
//        candidateTableView.estimatedRowHeight = 130
    }
    
    func bindRx() {
        categoryButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.presentActionSheet(title: "선거 종류", actions: self.getActions())
            }).disposed(by: rx.disposeBag)
    }
    
    func fetchCandidates() {
        self.activityIndicator.startAnimating()
        viewModel!.fetchElectionKeys(errorHandler: { [weak self] error in
            self?.activityIndicator.stopAnimating()
            self?.showNetworkErrorView {
                self?.fetchCandidates()
            }
        }) { [weak self] in
            self?.candidateTableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func getActions() -> [UIAlertAction] {
        let action1 = UIAlertAction(title: ElectionType.nationalAssembly.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.nationalAssembly.rawValue, for: .normal)
            self?.viewModel!.switchElectionType(electionType: .nationalAssembly)
            self?.fetchCandidates()
        }
        let action2 = UIAlertAction(title: ElectionType.guMayor.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.guMayor.rawValue, for: .normal)
            self?.viewModel!.switchElectionType(electionType: .guMayor)
            self?.fetchCandidates()
        }
        let action3 = UIAlertAction(title: ElectionType.siCouncil.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.siCouncil.rawValue, for: .normal)
            self?.viewModel!.switchElectionType(electionType: .siCouncil)
            self?.fetchCandidates()
        }
        let action4 = UIAlertAction(title: ElectionType.guCouncil.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.guCouncil.rawValue, for: .normal)
            self?.viewModel!.switchElectionType(electionType: .guCouncil)
            self?.fetchCandidates()
        }
        var actions = [UIAlertAction]()
        if !viewModel!.electionName.congress.isEmpty {
            actions.append(action1)
        }
        if !viewModel!.electionName.guMayor.isEmpty {
            actions.append(action2)
        }
        if !viewModel!.electionName.siCouncil.isEmpty {
            actions.append(action3)
        }
        if !viewModel!.electionName.guCouncil.isEmpty {
            actions.append(action4)
        }
        
        return actions
    }
}

extension CandidateSearchListResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel!.congressCandidateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: AdCandidateCell.className, for: indexPath) as? AdCandidateCell {
                
            if adFlag {
                cell.heightObservable
                    .subscribe(onNext: { [weak self] height in
                        self?.adHeight = height
                        cell.adViewHeightConstraint.constant = height
                        cell.layoutIfNeeded()
                        
                        if height != 0 {
                            tableView.reloadData()
                        }
                        
                    }).disposed(by: rx.disposeBag)
                NativeAdMobManager.share.createAd(delegate: cell, viewController: self, type: .candidate)
                NativeAdMobManager.share.showAd(type: .candidate)
                adFlag = false
            }
            
            return cell
        }
//        if let cell = tableView.dequeueReusableCell(withIdentifier: AdCandidateCell.className, for: indexPath) as? AdCandidateCell,
//            indexPath.row == 0 {
//
//            if adFlag {
//                cell.heightObservable
//                    .subscribe(onNext: { [weak self] height in
//                        self?.adHeight = height
////                        tableView.reloadRows(at: [indexPath], with: .none)
//                        tableView.deleteRows(at: [indexPath], with: .fade)
//                    }).disposed(by: rx.disposeBag)
//                NativeAdMobManager.share.createAd(delegate: cell, viewController: self)
//                NativeAdMobManager.share.showAd()
//                adFlag = false
//            }
//
//            return cell
//        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CandidateCell.className, for: indexPath) as? CandidateCell else { return UITableViewCell() }
        
        cell.setCandidate(candidateInfo: viewModel!.congressCandidateList[indexPath.row], sourceResult: sourceResult)
        
        return cell
    }
    
    
}

extension CandidateSearchListResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 { return }
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: CandidateSearchResultViewController.className) as? CandidateSearchResultViewController {
            
            vc.candidate = viewModel!.congressCandidateList[indexPath.row]
            vc.districtString = viewModel!.districtString
            vc.sourceResult = sourceResult
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return adHeight
        } else {
        return 130
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
