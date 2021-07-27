//
//  SponsorViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/29.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import StoreKit
import RxSwift
import RxCocoa

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
        
        self.activityIndicator.startAnimating()
        SponsorProducts.store.requestProducts { [weak self] success, products in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
            
            guard let `self` = self else { return }
            if success {

                guard let products = products else { return }

                for product in products {
                    if product.productIdentifier == SponsorProducts.canProductId {
                        self.sponsorItems.append(SponsorItem(image: UIImage(named: "ic_can")!, title: "캔커피 1개", priceString: "1200원", price: 1200, detail: "캔커피 1개 값의 후원은 저희에게 소소한 보람이됩니다.", product: product))
                    } else if product.productIdentifier == SponsorProducts.cafeCoffeeProductId {
                        self.sponsorItems.append(SponsorItem(image: UIImage(named: "ic_coffee")!, title: "커피 1잔", priceString: "3900원", price: 2900, detail: "커피 1잔 값의 후원은 저희를 춤추게합니다 ♩ ♪ ♬", product: product))
                    } else if product.productIdentifier == SponsorProducts.coffeeCakeProductId {
                        self.sponsorItems.append(SponsorItem(image: UIImage(named: "ic_cake")!, title: "커피 & 디저트", priceString: "9900원", price: 9900, detail: "커피와 디저트 후원으로 개발자와 디자이너가 활력을 얻습니다!", product: product))
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
        

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(noticePurchased(_:)),
                                               name: .IAPHelperPurchaseNotification,
                                               object: nil)
    }
    
    func showAlert(alertTitle title: String, alertMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func noticePurchased(_ notification: Notification) {

        guard
          let id = notification.object as? String,
            let index = sponsorItems.firstIndex(where: { item -> Bool in
                item.product.productIdentifier == id
          })
        else { return }

        self.showAlert(alertTitle: "후원해주셔서 감사합니다!", alertMessage: "\(sponsorItems[index].title) 후원이라니..!!\n더 좋은 앱으로 보답하겠습니다.\n진심으로 감사드립니다.")
    }
}

extension SponsorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sponsorItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SponsorItemCell.className, for: indexPath) as? SponsorItemCell else { return UITableViewCell() }
        
        cell.setData(sponsorItem: sponsorItems[indexPath.row])
        cell.buySubject
            .subscribe(onNext: { product in
                guard let product = product else { return }
                
                SponsorProducts.store.buyProduct(product)

            }).disposed(by: disposeBag)
        return cell
    }
}

extension SponsorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
