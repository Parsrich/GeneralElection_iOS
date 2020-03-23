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
import NSObject_Rx

enum ElectionType: String {
    case nationalAssembly = "국회의원선거"
    case siMayor = "시∙도의 장선거"
    case guMayor = "구∙시∙군의 장선거"
    case siCouncil = "시∙도의회의원선거"
    case guCouncil = "구∙시∙군의회의원선거"
}

class DistrictSearchViewController: BaseViewControllerWithViewModel<DistrictSearchViewModel> {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
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
    }
    
    func fetchLocation(location: String? = nil) {
        self.activityIndicator.startAnimating()
        self.viewModel!.fetchDistrictKeys(location: location) { [weak self] in
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func getActions() -> [UIAlertAction] {
        let action1 = UIAlertAction(title: ElectionType.nationalAssembly.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.nationalAssembly.rawValue, for: .normal)
            self?.fetchLocation()
        }
        let action2 = UIAlertAction(title: ElectionType.guMayor.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.guMayor.rawValue, for: .normal)
            self?.fetchLocation()
        }
        let action3 = UIAlertAction(title: ElectionType.siCouncil.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.siCouncil.rawValue, for: .normal)
            self?.fetchLocation()
        }
        let action4 = UIAlertAction(title: ElectionType.guCouncil.rawValue, style: .default) { [weak self] _ in
            self?.categoryButton.setTitle(ElectionType.guCouncil.rawValue, for: .normal)
            self?.fetchLocation()
        }
        return [action1, action2, action3, action4]
    }
}

extension DistrictSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.locationSiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.className, for: indexPath) as? CityCell else { return UITableViewCell() }
        
        cell.cityName.text = viewModel!.locationSiList[indexPath.row].key
//        cell.cityName.text = viewModel!.locations[indexPath.row]?.
        
        return cell
    }
}

extension DistrictSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

//        fetchLocation(location: viewModel!.locations[indexPath.row])
    }
}
