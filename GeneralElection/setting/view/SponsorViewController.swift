//
//  SponsorViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/29.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

class SponsorViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomMessageLabel: UILabel! {
        didSet {
            self.bottomMessageLabel.text = "더 좋은 앱을 만들기 위해\n후원부탁드립니다 :)"
        }
    }
    var sponsorItems = [SponsorItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setup()
    }
    
    func setupUI() {
        setTransparentNavigationController(true)
        setShadowViewUnderNavigationController()
    }
    
    func setup() {
    
        sponsorItems.append(SponsorItem(image: UIImage(named: "ic_can")!, title: "캔커피 1개", priceString: "1천원", price: 1000))
        sponsorItems.append(SponsorItem(image: UIImage(named: "ic_coffee")!, title: "커피 1잔", priceString: "3천원", price: 3000))
        sponsorItems.append(SponsorItem(image: UIImage(named: "ic_cake")!, title: "커피 & 디저트", priceString: "1만원", price: 10000))
    }
    
    func showAlert(alertTitle title: String, alertMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension SponsorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sponsorItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SponsorItemCell.className, for: indexPath) as? SponsorItemCell else { return UITableViewCell() }
        
        cell.setData(sponsorItem: sponsorItems[indexPath.row])
        cell.completionSubject
            .subscribe(onNext: { [weak self]  _ in
            
                self?.showAlert(alertTitle: "후원해주셔서 감사합니다!",
                                alertMessage: "더 좋은앱으로 보답하겠습니다.\n진심으로 감사드립니다.")
            }).disposed(by: rx.disposeBag)
        return cell
    }
}

extension SponsorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
