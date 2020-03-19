//
//  SettingViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class SettingViewController: BaseViewControllerWithViewModel<SettingViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        setTransparentNavigationController()
        setShadowViewUnderNavigationController()
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.className, for: indexPath) as? SettingCell else { return UITableViewCell() }
        
        cell.titleLabel?.text = viewModel!.settingList[indexPath.row]
        
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
