//
//  CandidateSearchViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/12.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift

class CandidateSearchViewModel: BaseViewModel {
    
    var candidateNameList: [String]?
    
    func searchByKeyword(keyword: String?) -> [Candidate] {
        guard let keyword = keyword else { return [Candidate]() }
        return CandidateMemory.candidateDataList(keyword: keyword)
    }
    
    func showKeywordList(keyword: String) {
        if keyword.isEmpty { return }
        guard let list = CandidateMemory.candidateNameList?.filter({ name -> Bool in
            name.prefix(keyword.count) == keyword
//            name.contains(keyword)
        }) else { return }
        
        candidateNameList = list.sorted { $0 < $1 }
    }
}
