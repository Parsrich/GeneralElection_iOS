//
//  DistrictSearchViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx

class DistrictSearchViewController: BaseViewControllerWithViewModel<DistrictSearchViewModel> {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var siTableView: UITableView!
    @IBOutlet weak var guTableView: UITableView!
    @IBOutlet weak var dongTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var locationTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindRx()
        setup()
    }
    
    func setup() {
        fetchLocation()
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
        categoryButton.titleLabel?.lineBreakMode = .byWordWrapping
        categoryButton.setTitle(ElectionType.nationalAssembly.rawValue, for: .normal)
    }
    
    func bindRx() {
        categoryButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.presentActionSheet(title: "정당선택", actions: self.getActions())
            }).disposed(by: rx.disposeBag)
        
        backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                if self.viewModel!.locationType == .gu {
                    self.switchTableView(nextTableView: self.siTableView)
                    self.backButton.isEnabled = false
                } else if self.viewModel!.locationType == .dong {
                    self.switchTableView(nextTableView: self.guTableView)
                }
                self.viewModel!.switchLocationType(true)
            }).disposed(by: rx.disposeBag)
    }
    
    func switchTableView(nextTableView: UITableView) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.siTableView.alpha = 0.0
            self?.guTableView.alpha = 0.0
            self?.dongTableView.alpha = 0.0
        }) { _ in
            UIView.animate(withDuration: 0.3) { [weak self] in
                nextTableView.alpha = 1.0
                nextTableView.reloadData()
                self?.locationTitleLabel.text = self?.viewModel!.locationText.rawValue
            }
        }
    }
    
    func fetchLocation(location: String? = nil) {
        self.activityIndicator.startAnimating()
        self.viewModel!.fetchDistrictKeys(location: location) { [weak self] in
            self?.siTableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func getActions() -> [UIAlertAction] {
        let action1 = UIAlertAction(title: ElectionType.nationalAssembly.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.nationalAssembly.rawValue, for: .normal)
            self?.fetchLocation()
            self?.viewModel!.switchElectionType(electionType: .nationalAssembly)
        }
        let action2 = UIAlertAction(title: ElectionType.guMayor.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.guMayor.rawValue, for: .normal)
            self?.fetchLocation()
            self?.viewModel!.switchElectionType(electionType: .guMayor)
        }
        let action3 = UIAlertAction(title: ElectionType.siCouncil.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.siCouncil.rawValue, for: .normal)
            self?.fetchLocation()
            self?.viewModel!.switchElectionType(electionType: .siCouncil)
        }
        let action4 = UIAlertAction(title: ElectionType.guCouncil.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.guCouncil.rawValue, for: .normal)
            self?.fetchLocation()
            self?.viewModel!.switchElectionType(electionType: .guCouncil)
        }
        return [action1, action2, action3, action4]
    }
}

extension DistrictSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch tableView {
        case siTableView:
            count = viewModel!.locationSiList.count
        case guTableView:
            count = viewModel!.locationGuList.count
        case dongTableView:
            count = viewModel!.locationDongList.count
        default:
            break
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.className, for: indexPath) as? CityCell else { return UITableViewCell() }
        
        switch tableView {
        case siTableView:
            cell.cityName.text = viewModel!.locationSiList[indexPath.row].key
        case guTableView:
            cell.cityName.text = viewModel!.locationGuList[indexPath.row].key
        case dongTableView:
            cell.cityName.text = viewModel!.locationDongList[indexPath.row].key
        default:
            break
        }
                
        return cell
    }
}

extension DistrictSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.backButton.isEnabled = true
        
        switch tableView {
        case siTableView:
            self.viewModel!.setLocationGuList(selectedIndex: indexPath.row)
            switchTableView(nextTableView: self.guTableView)
        case guTableView:
            self.viewModel!.setLocationDongList(selectedIndex: indexPath.row)
            switchTableView(nextTableView: self.dongTableView)
        case dongTableView:
            self.viewModel!.setCongress(selectedIndex: indexPath.row)
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: CandidateSearchListResultViewController.className) as? CandidateSearchListResultViewController {
                
                vc.electionType = self.viewModel!.electionType
                vc.electionName = self.viewModel!.electionName.getElectionName(electionType: self.viewModel!.electionType)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }

        self.viewModel!.switchLocationType(false)
    }
}
