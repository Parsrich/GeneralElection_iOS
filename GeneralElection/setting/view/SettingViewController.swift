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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        setTransparentNavigationController(true)
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
        if indexPath.row == 3 {
            cell.rightImage.isHidden = true
        }
        
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            performSegue(withIdentifier: "IntroduceSegue", sender: self)
        } else if indexPath.row == 1 {
            

//            let mailtoString = "mailto:ohjooyeo.donam@gmail.com?subject=문의사항&body=1. 문의분류\n정보 수정 요청, 기능오류, 제휴/광고문의, 기타문의\n2. 문의 내용\n"
//            let url = URL(string: mailtoString)
//            if UIApplication.shared.canOpenURL(url!) {
//                UIApplication.shared.open(url!, options: [:])
//            }

            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["ohjooyeo.donam@gmail.com"])
                mail.setSubject("# 총선 앱 문의")
                mail.setMessageBody("1. 문의분류\n정보 수정 요청, 기능오류, 제휴/광고문의, 기타문의\n2. 문의 내용\n", isHTML: true)

                present(mail, animated: true)
            } else {
                present(showConfirmationAlert(alertTitle: "기본 앱 이메일이 설정되어있지 않습니다.", alertMessage: "Mail앱에서 email을 설정하세요."), animated: true)
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
