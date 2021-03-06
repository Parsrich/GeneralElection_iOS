//
//  CandidateSearchResultViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/20.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Kingfisher

enum SourceResult {
    case districtSearch
    case candidateSearch
    case partySearch
}

class CandidateSearchResultViewController: BaseViewControllerWithViewModel<CandidateSearchResultViewModel> {
    
    @IBOutlet weak var mapIconView: UIImageView!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var numberBackView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var partyBackView: UIView!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var imageExpandButton: UIButton!
    @IBOutlet weak var detailDocumentButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backgroundShadowView: UIView!
    @IBOutlet weak var bigProfileBackView: UIView!
    @IBOutlet weak var bigProfileImageView: UIImageView!
    @IBOutlet weak var bigProfileCloseButton: UIButton!
    
    @IBOutlet weak var districtLabelLeadingConstraint: NSLayoutConstraint!
    
    var candidate: Candidate?
    var districtString: String?
    var sourceResult: SourceResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let candidate = candidate {
            viewModel!.candidate = candidate
        }
        if let districtString = districtString {
            viewModel!.districtString = districtString
        }
        
        setupUI()
        setup()
        bindRx()
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidePopup(_:)))
        
        backgroundShadowView.addGestureRecognizer(tapGesture)
        bigProfileBackView.addGestureRecognizer(tapGesture)
        backgroundShadowView.addGestureRecognizer(tapGesture)
        bigProfileImageView.layer.borderColor = UIColor.black.cgColor
        bigProfileImageView.layer.borderWidth = 3.0

        if let sourceResult = self.sourceResult {
            switch sourceResult {
            case .partySearch, .candidateSearch:
                if candidate?.recommend != nil {
                    districtLabelLeadingConstraint.priority = .defaultHigh
                }
            default:
                break
            }
        }
    }
    
    func setup() {
        viewModel!.setDetailInfo()
        districtLabel.text = "\(candidate?.si ?? "") \(candidate?.district ?? "")" //candidate?.recommend == nil ? districtString :
//        candidate?.district
        
        numberBackView.backgroundColor = PartySource.getPartyColor(party: candidate?.party ?? "")
//        if let sourceResult = sourceResult {
//            switch sourceResult {
//            case .candidateSearch, .districtSearch:
//                numberLabel.text = "기호\(candidate?.number ?? "")"
//            case .partySearch:
//                numberLabel.text = candidate?.recommend
//            }
//        }
        mapIconView.isHidden = (candidate?.recommend != nil)
        

        numberLabel.text = candidate?.recommend == nil ? "기호\(candidate?.number ?? "")" : "번호\(candidate?.recommend ?? "")"
        partyBackView.backgroundColor = PartySource.getPartyColor(party: candidate?.party ?? "")
        partyLabel.text = candidate?.party
        nameLabel.text = candidate?.name
        birthLabel.text = candidate?.age
        addressLabel.text = candidate?.address
        
        if let imgUrl = candidate?.imageUrl {
            let url = URL(string: imgUrl)
            thumbnailImageView
                .kf
                .setImage(with: url,
                          placeholder: UIImage(named: "ic_user_empty"))
            bigProfileImageView
                .kf
                .setImage(with: url,
                          placeholder: UIImage(named: "ic_user_empty"))
        }
        
    }
    
    func bindRx() {
        
        imageExpandButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.showBigImage(true)
            })
            .disposed(by: rx.disposeBag)
        
        detailDocumentButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
               
                if let vc = self?.storyboard?.instantiateViewController(withIdentifier: CandidateDetailWebViewController.className) as? CandidateDetailWebViewController {
                   
                    vc.url = self?.candidate?.getPersonalInfoUrl()
                    vc.navigationTitle = "후보자 상세"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: rx.disposeBag)
        
        bigProfileCloseButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.showBigImage(false)
            })
            .disposed(by: rx.disposeBag)
            
    }
    
    func showBigImage(_ isShow: Bool) {
        backgroundShadowView.isHidden = !isShow
        bigProfileBackView.isHidden = !isShow
    }
    
    @objc func hidePopup(_ gesture: UITapGestureRecognizer) {
        showBigImage(false)
    }
}

extension CandidateSearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.detailInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CandidateDetailCell.className, for: indexPath) as? CandidateDetailCell else { return UITableViewCell() }
        
        cell.titleLabel.text = viewModel!.detailInfo?[indexPath.row].title
        cell.contentLabel.text = viewModel!.detailInfo?[indexPath.row].content
        
        return cell
    }
}

extension CandidateSearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70//UITableView.automaticDimension
    }
}
