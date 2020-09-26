//
//  PartyDetailViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/04.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Kingfisher

class PartyDetailViewController: BaseViewControllerWithViewModel<PartyDetailViewModel> {
    
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var proportionNumberLabel: UILabel!
    @IBOutlet weak var partyLogoImageView: UIImageView!
    @IBOutlet weak var partyNamePromiseLabel: UILabel!
    @IBOutlet weak var proportionalButton: UIButton!
    @IBOutlet weak var partyIssueButton: UIButton!
    @IBOutlet weak var promiseTableView: UITableView!
    @IBOutlet weak var logoContainerView: UIView!
    
    @IBOutlet weak var popupShadowView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupCloseButton: UIButton!
    @IBOutlet weak var popupSubjectLabel: UILabel!
    @IBOutlet weak var popupTitleLabel: UILabel!
    @IBOutlet weak var popupContentTextView: UITextView!
    @IBOutlet weak var emptyPromiseView: UIImageView!
//    var isPopupShow: Bool = false {
//        didSet {
//            self.popupShadowView.isHidden = !self.isPopupShow
//            self.popupView.isHidden = !self.isPopupShow
//        }
//    }
    
    var sourceResult: SourceResult?
    var partyName: String?
    var candidateList: [Candidate]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let partyName = partyName {
            viewModel!.partyName = partyName
        }
        
        setupUI()
        setup()
        bindRx()
    }
    
    func setupUI() {
        setTransparentNavigationController(true)
        setShadowViewUnderNavigationController()
        popupView.layer.borderColor = UIColor.black.cgColor
        popupView.layer.borderWidth = 1.0
        logoContainerView.layer.borderColor = UIColor.lightGray.cgColor
        logoContainerView.layer.borderWidth = 1.0
        promiseTableView.rowHeight = 60
        promiseTableView.estimatedRowHeight = UITableView.automaticDimension
        
        if partyName?.contains("가자!평화인권당") == true {
            partyLogoImageView.backgroundColor = UIColor.init(hex: "#65A032")
        } else {
            partyLogoImageView.backgroundColor = UIColor.white
        }
        
        partyLogoImageView.image = UIImage(named: partyName ?? "ic_loading")
//        partyLogoImageView
//            .kf
//            .setImage(with: partyImageUrl,
//                  placeholder: UIImage(named: partyName ?? "ic_loading"))
        partyNameLabel.text = partyName
        partyNamePromiseLabel.text = "\(partyName ?? "") 공약"
        
        let proportionalNumber = PartySource.getPartyProportionalNumber(party: viewModel!.partyName)
        
        if proportionalNumber == 0 {
            proportionalButton.isEnabled = false
            proportionNumberLabel.text = ""
        } else {
            proportionalButton.isEnabled = true
            proportionNumberLabel.text = "비례정당번호 \(proportionalNumber)"
        }
        
        
        
    }
    
    func setup() {
        fetchPartyPromise()
    }
    
    func bindRx() {
        proportionalButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: CandidateSearchListResultViewController.className) as? CandidateSearchListResultViewController {
        
                    vc.viewModel!.districtString = "\(self.partyName ?? "") 비례대표 명단"
                    vc.viewModel!.setDataFromCandidateSearchVC(candidates: self.candidateList ?? [Candidate]())
//                    vc.candidates = self.candidateList
//                    vc.districtString = "\(self.partyName ?? "") 비례대표 명단"
                    vc.sourceResult = .partySearch
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: rx.disposeBag)
        
        partyIssueButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                
                if let vc = self?.storyboard?.instantiateViewController(withIdentifier: CandidateDetailWebViewController.className) as? CandidateDetailWebViewController,
                    let partyName = self?.partyName {
                    
                    var fullPartyName = partyName
                    if partyName == "코리아" {
                        fullPartyName = "가자코리아"
                    } else if partyName == "새벽당" {
                        fullPartyName = "자유의새벽당"
                    } else if partyName == "자영업당" {
                        fullPartyName = "중소자영업당"
                    }
                    
                    vc.url = URL(string: "https://namu.wiki/w/\(fullPartyName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
                    vc.navigationTitle = "정당 정보 위키"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: rx.disposeBag)
        
        popupCloseButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                UIView.animate(withDuration: 0.5, animations: {
                    self?.popupView.alpha = 0.0
                    self?.popupShadowView.alpha = 0.0
                }) { _ in
                    self?.popupSubjectLabel.text = ""
                    self?.popupTitleLabel.text = ""
                    self?.popupContentTextView.text = ""
                }
                
            }).disposed(by: rx.disposeBag)
    }
    
    func setPopupData(promise: Promise?) {
        guard let promise = promise else { return }
        
        self.popupSubjectLabel.text = "[\(promise.realmName ?? "")]"
        self.popupTitleLabel.text = "\(promise.ord ?? ""). \(promise.title ?? "")"
        self.popupContentTextView.text = promise.content
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.popupView.alpha = 1.0
            self?.popupShadowView.alpha = 0.5
        }
    }
    
    func fetchPartyPromise() {
        viewModel!.fetchPartyPromise(errorHandler: { [weak self] error in
            self?.activityIndicator.stopAnimating()
            self?.showNetworkErrorView {
                self?.fetchPartyPromise()
            }
        }) { [weak self] in

            self?.emptyPromiseView.isHidden = (self?.viewModel!.partyPromiseList?.count ?? 0) != 0
            self?.promiseTableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
}

extension PartyDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.partyPromiseList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PartyPromiseCell.className, for: indexPath) as? PartyPromiseCell else { return UITableViewCell() }
        
        cell.setData(promise: viewModel!.partyPromiseList?[indexPath.row])
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor(hex: "#F1F1F2")
        } else {
            cell.contentView.backgroundColor = UIColor.white
        }
        
        return cell
    }
}

extension PartyDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        setPopupData(promise: viewModel!.partyPromiseList?[indexPath.row])
    }
}
