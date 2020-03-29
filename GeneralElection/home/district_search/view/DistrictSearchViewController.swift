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
    @IBOutlet weak var siTableView: UITableView!
    @IBOutlet weak var guTableView: UITableView!
    @IBOutlet weak var dongTableView: UITableView!
    
    @IBOutlet weak var siButton: UIButton!
    @IBOutlet weak var siGuMid: UILabel!
    @IBOutlet weak var guButton: UIButton!
    @IBOutlet weak var guDongMid: UILabel!
    @IBOutlet weak var dongButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindRx()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel!.locationType == .selectedDone {
            self.viewModel!.switchLocationType(.dong)
        }
    }
    
    func setup() {
        fetchLocation()
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
        setLocationBackgroundColor()
        
        siButton.titleLabel?.numberOfLines = 1
        guButton.titleLabel?.numberOfLines = 1
        dongButton.titleLabel?.numberOfLines = 1
        siButton.titleLabel?.minimumScaleFactor = 0.5
        guButton.titleLabel?.minimumScaleFactor = 0.5
        dongButton.titleLabel?.minimumScaleFactor = 0.5
        
        siButton.titleLabel?.adjustsFontSizeToFitWidth = true
        guButton.titleLabel?.adjustsFontSizeToFitWidth = true
        dongButton.titleLabel?.adjustsFontSizeToFitWidth = true
    
        siButton.titleLabel?.adjustsFontForContentSizeCategory = true
        guButton.titleLabel?.adjustsFontForContentSizeCategory = true
        dongButton.titleLabel?.adjustsFontForContentSizeCategory = true
        
        siButton.titleLabel?.allowsDefaultTighteningForTruncation = true
        guButton.titleLabel?.allowsDefaultTighteningForTruncation = true
        dongButton.titleLabel?.allowsDefaultTighteningForTruncation = true
    }
    
    func bindRx() {
        siButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.viewModel!.switchLocationType(.si)
                self.siButton.setTitle("시・도", for: .normal)
                self.viewModel!.currentDistrict.removeAll()
                self.isLocationGuButtonOn(isOn: false)
                self.switchTableView(nextTableView: self.siTableView)
                self.setLocationBackgroundColor()
            }).disposed(by: rx.disposeBag)
            
        guButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.viewModel!.switchLocationType(.gu)
                self.viewModel!.currentDistrict.removeSubrange(1...)
                self.guButton.setTitle("구・시・군", for: .normal)
                self.isLocationDongButtonOn(isOn: false)
                self.switchTableView(nextTableView: self.guTableView)
                self.setLocationBackgroundColor()
            }).disposed(by: rx.disposeBag)
    }
    
    func switchTableView(nextTableView: UITableView) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.siTableView.alpha = 0.0
            self?.guTableView.alpha = 0.0
            self?.dongTableView.alpha = 0.0
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                nextTableView.alpha = 1.0
                nextTableView.reloadData()
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
    
    func isLocationGuButtonOn(isOn: Bool) {
        if !isOn {  /// gu버튼이 사라지게 할때(시버튼 누른경우),
            isLocationDongButtonOn(isOn: isOn) /// dong버튼 알아서 사라지게.
        }
        self.guButton.isHidden = !isOn
        self.siGuMid.isHidden = !isOn
    }
    
    func isLocationDongButtonOn(isOn: Bool) {
        self.dongButton.isHidden = !isOn
        self.guDongMid.isHidden = !isOn
    }
    
    func setLocationBackgroundColor() {

        self.siButton.isEnabled = viewModel!.locationType != .si
        self.guButton.isEnabled = viewModel!.locationType != .gu
        self.dongButton.isEnabled = viewModel!.locationType != .dong
        
        if viewModel!.locationType == .si {
            self.siButton.backgroundColor = UIColor(hex: "#7269EA")
            self.guButton.backgroundColor = UIColor(hex: "#CECCCD")
            self.dongButton.backgroundColor = UIColor(hex: "#CECCCD")
        } else if viewModel!.locationType == .gu {
            self.siButton.backgroundColor = UIColor(hex: "#CECCCD")
            self.guButton.backgroundColor = UIColor(hex: "#7269EA")
            self.dongButton.backgroundColor = UIColor(hex: "#CECCCD")
        } else if viewModel!.locationType == .dong {
            self.siButton.backgroundColor = UIColor(hex: "#CECCCD")
            self.guButton.backgroundColor = UIColor(hex: "#CECCCD")
            self.dongButton.backgroundColor = UIColor(hex: "#7269EA")
        }
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
        setLocationBackgroundColor()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        switch tableView {
        case siTableView:
            self.viewModel!.setLocationGuList(selectedIndex: indexPath.row)
            self.siButton.setTitle(viewModel!.locationSiList[indexPath.row].key, for: .normal)
            self.guButton.setTitle("구・시・군", for: .normal)
            switchTableView(nextTableView: self.guTableView)
            isLocationGuButtonOn(isOn: true)
            self.viewModel!.switchLocationType(.gu)
        case guTableView:
             self.guButton.setTitle(viewModel!.locationGuList[indexPath.row].key, for: .normal)
            self.viewModel!.setLocationDongList(selectedIndex: indexPath.row)
            switchTableView(nextTableView: self.dongTableView)
            isLocationDongButtonOn(isOn: true)
            self.viewModel!.switchLocationType(.dong)
        case dongTableView:
            self.viewModel!.setCongress(selectedIndex: indexPath.row)
            self.viewModel!.switchLocationType(.selectedDone)
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: CandidateSearchListResultViewController.className) as? CandidateSearchListResultViewController {
                
                vc.electionType = self.viewModel!.electionType
                vc.electionName = self.viewModel!.electionName
                let district = "\(siButton.currentTitle ?? "") > \(guButton.currentTitle ?? "") > \(viewModel!.locationDongList[indexPath.row].key)"
                vc.districtString = district
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }

        setLocationBackgroundColor()
    }
}
