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

class DistrictSearchViewController: BaseViewControllerWithViewModel<DistrictSearchViewModel> {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        backgroundView.makeShadow(shadowRadius: 5.0)
        categoryButton.makeShadow(shadowRadius: 5.0)
        setShadowViewUnderNavigationController()
    }
}

extension DistrictSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.className, for: indexPath) as? CityCell else { return UITableViewCell() }
        
        cell.cityName.text = cities[indexPath.row]
        
        return cell
    }
}

extension DistrictSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select! \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
