//
//  CandidateSearchResultViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/20.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift

class CandidateSearchResultViewModel: BaseViewModel {
    
    var candidate: Candidate?
    var districtString: String?
    
    required init() {
        super.init()
        
    }
}
