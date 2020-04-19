//
//  CandidateCellViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/04/19.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

class CandidateCellViewModel: BaseCellViewModel {
    
    var candidate: Candidate?
    var sourceResult: SourceResult?
    
    func setCandidate(candidate: Candidate, sourceResult: SourceResult?) {
        self.candidate = candidate
        self.sourceResult = sourceResult
    }
}
