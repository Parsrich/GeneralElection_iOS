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

class CandidateSearchListResultViewController: BaseViewControllerWithViewModel<CandidateSearchListResultViewModel> {
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var candidateTableView: UITableView!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var emptyView: UIImageView!
    
    var electionType: ElectionType?
    var electionName: LocationElectionName?
    var districtString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
//        Congress.reset()
        if let type = electionType, let name = electionName, let districtString = districtString {
            viewModel!.electionType = type
            viewModel!.electionName = name
            viewModel!.districtString = districtString
        }
        
        setupUI()
        bindRx()
        setup()
    }
    
    func setup() {
        fetchCandidates()
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
       
        locationLabel.text = viewModel!.electionName.getElectionName(electionType: viewModel!.electionType).replacingOccurrences(of: "_", with: " ")
        
        emptyView.isHidden = !viewModel!.electionName.isEmpty
        categoryButton.setTitle(viewModel!.electionType.rawValue, for: .normal)
        
        districtLabel.text = districtString
        
        candidateTableView.rowHeight = UITableView.automaticDimension
        candidateTableView.estimatedRowHeight = 130
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
        viewModel!.fetchElectionKeys { [weak self] in
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.congressCandidateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CandidateCell.className, for: indexPath) as? CandidateCell else { return UITableViewCell() }
        
        cell.setCandidate(candidateInfo: viewModel!.congressCandidateList[indexPath.row])
        
        return cell
    }
    
    
}

extension CandidateSearchListResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: CandidateSearchResultViewController.className) as? CandidateSearchResultViewController {
            
            vc.candidate = viewModel!.congressCandidateList[indexPath.row]
            vc.districtString = viewModel!.districtString
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
