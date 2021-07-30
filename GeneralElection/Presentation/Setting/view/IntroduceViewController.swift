//
//  IntroduceViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/05.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import Foundation

class IntroduceViewController: BaseViewController {
    
    var noticeList: [NoticeContents]?
    var savedMessage: String? {
        get {
            return UserDefaults.standard.string(forKey: "introduceMessage")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "introduceMessage")
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        

        let messageJson = FirebaseManager.share.stringValue(key: .introduceMessage)
        
//        if messageJson != "" {
//            self.savedMessage = messageJson
//        }

        self.getData(messageJson: messageJson)
    }
    
    func getData(messageJson: String?) {

        if self.noticeList == nil {
            self.noticeList = [NoticeContents]()
        }
        
        self.activityIndicator.startAnimating()
        
        guard let data = messageJson?.data(using: .utf8),
            let notices = try? JSONDecoder().decode(data: data, dataType: [NoticeContents].self) else {
            
            var contents = NoticeContents()
            contents.contents = "공지사항이 없습니다."
            noticeList?.append(contents)
            tableView.reloadData()
            
            return
        }
        
        self.noticeList?.append(contentsOf: notices)
//        for notice in notices {
//
//            if let contents = notice.contents {
//                self.noticeList?.append(contents)
//            }
//        }
        tableView.reloadData()
        
        self.activityIndicator.stopAnimating()
    }
}

extension IntroduceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingNoticeCell.className, for: indexPath) as? SettingNoticeCell else { return UITableViewCell() }
        
        cell.titleLabel.text = noticeList?[indexPath.row].contents
        
        
        let string              = noticeList?[indexPath.row].contents ?? ""
        let range               = (string as NSString).range(of: (noticeList?[indexPath.row].underbarContents) ?? "")
        let attributedString    = NSMutableAttributedString(string: string)

        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: 1), range: range)
       

        cell.titleLabel.attributedText = attributedString
        
        return cell
    }
    
    
}

extension IntroduceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
}
