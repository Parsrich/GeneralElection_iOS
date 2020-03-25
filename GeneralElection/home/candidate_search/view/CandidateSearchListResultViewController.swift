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
    
    var electionType: ElectionType?
    var electionName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let type = electionType, let name = electionName {
            viewModel!.electionType = type
            viewModel!.electionName = name
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
        categoryButton.setTitle(viewModel!.electionType.rawValue, for: .normal)
        locationLabel.text = viewModel!.electionName
    }
    
    func bindRx() {
        categoryButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.presentActionSheet(title: "정당선택", actions: self.getActions())
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
        return [action1, action2, action3, action4]
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
}
