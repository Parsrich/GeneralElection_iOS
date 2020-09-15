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
    
    var partyImageUrl: URL?
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
        logoContainerView.layer.borderColor = UIColor.lightGray.cgColor
        logoContainerView.layer.borderWidth = 1.0
//        promiseTableView.rowHeight = 130
        promiseTableView.estimatedRowHeight = UITableView.automaticDimension
        
        if partyName?.contains("가자!평화인권당") == true {
            partyLogoImageView.backgroundColor = UIColor.init(hex: "#65A032")
        } else {
            partyLogoImageView.backgroundColor = UIColor.white
        }
        
        partyLogoImageView
            .kf
            .setImage(with: partyImageUrl,
                  placeholder: UIImage(named: "ic_button"))
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
        
                    vc.districtString = "\(self.partyName ?? "") 비례대표 명단"
                    vc.candidates = self.candidateList
                    vc.sourceResult = .partySearch
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: rx.disposeBag)
        
        partyIssueButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                
                if let vc = self?.storyboard?.instantiateViewController(withIdentifier: CandidateDetailWebViewController.className) as? CandidateDetailWebViewController,
                    let partyName = self?.partyName {
                    
                    vc.url = URL(string: "https://m.search.zum.com/search.zum?method=news&qm=f_typing.news&query=\(partyName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
                    vc.navigationTitle = "정당이슈"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: rx.disposeBag)
    }
    
    func fetchPartyPromise() {
        viewModel!.fetchPartyPromise(errorHandler: { [weak self] error in
            self?.activityIndicator.stopAnimating()
            self?.showNetworkErrorView {
                self?.fetchPartyPromise()
            }
        }) { [weak self] in
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
        
        return cell
    }
}

extension PartyDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
