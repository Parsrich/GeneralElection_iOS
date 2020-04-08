//
//  PartySearchViewController.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/13.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

class PartySearchViewController: BaseViewControllerWithViewModel<PartySearchViewModel> {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setup()
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
        
    }
    
    func setup() {
        fetchCandidates()
    }
    
    func fetchCandidates() {
        self.activityIndicator.startAnimating()
        viewModel!.fetchPartyKeys(errorHandler: { [weak self] error in
        self?.activityIndicator.stopAnimating()
            self?.showNetworkErrorView {
                self?.fetchCandidates()
            }
        }) { [weak self] in
            self?.collectionView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
    
}

extension PartySearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel!.partyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PartyItemCell.className, for: indexPath) as? PartyItemCell else { return UICollectionViewCell() }
        
        cell.setData(info: viewModel!.partyList[indexPath.row])
        
        return cell
    }
    
    
}

extension PartySearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width-20.0)/2
        
        return CGSize(width: width, height: width*(9.0/8.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: PartyDetailViewController.className) as? PartyDetailViewController {
            
            vc.partyName = viewModel!.partyList[indexPath.row].name
            vc.candidateList = viewModel!.partyList[indexPath.row].proportional
                        
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: CandidateSearchListResultViewController.className) as? CandidateSearchListResultViewController {
//
//            let topText = "\(viewModel!.partyList[indexPath.row].name ?? "") 비례대표 명단"
//            vc.districtString = topText
//            vc.partyName = viewModel!.partyList[indexPath.row].name
//            vc.candidates = viewModel!.partyList[indexPath.row].proportional
//
//            vc.sourceResult = .partySearch
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
}
