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
    }
    
    func setupUI() {
        setShadowViewUnderNavigationController()
    }
}

extension PartySearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

extension PartySearchViewController: UICollectionViewDelegateFlowLayout {
    
}
