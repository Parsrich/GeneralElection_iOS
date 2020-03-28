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
import Carte
import MessageUI

class SettingViewController: BaseViewControllerWithViewModel<SettingViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setup()
    }
    
    func setupUI() {
        setTransparentNavigationController()
        setShadowViewUnderNavigationController()
        
        if let backgroundView = self.view as? BaseBackgroundView,
            let height = backgroundView.backgroundImageView?.frame.height {
            topConstraint.constant = height
            backgroundView.layoutIfNeeded()
        }
    }
    
    func setup() {
        viewModel!.firebaseFetchSubject
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] appVersion in
                guard let `self` = self else { return }
                self.viewModel!.appVersion = appVersion
                self.viewModel!.settingList[3] = "앱 버전: \(appVersion)"
                self.tableView.reloadData()
            }).disposed(by: rx.disposeBag)
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
        
        if indexPath.row == 1 {
//            UIApplication.shared.open(URL(string: "mailto:cmk330@naver.com")!, options: [:])

            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["cmk330@naver.com"])
                mail.setMessageBody("[문의내용을 사진과 함께 첨부해주시면 더 쉽게 도움을 드릴 수 있습니다.]", isHTML: true)

                present(mail, animated: true)
            }
        } else if indexPath.row == 2 {
            let carteViewController = CarteViewController()
            present(carteViewController, animated: true)
        }
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}