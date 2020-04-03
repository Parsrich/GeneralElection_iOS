//
//  CandidateSearchListResultViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/20.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift

class CandidateSearchListResultViewModel: BaseViewModel {
    
    var electionType: ElectionType
    var electionName: LocationElectionName
    var districtString = ""
    var congressCandidateList: [Candidate]
    
    // 정당 공약 볼때만 사용할 데이터
    var partyPromiseList: [Promise]?
    var partyName: String = ""
    
    required init() {
        electionType = .nationalAssembly
        electionName = LocationElectionName(dictionary: nil)
        
        congressCandidateList = [Candidate]()
        
        super.init()
    }
    
    func fetchElectionKeys(errorHandler: @escaping (Error) -> Void, completion: @escaping () -> Void) {
        
        var path: DatabasePath = .root
        switch electionType {
        case .nationalAssembly:
            path = .congress
            if Congress.congressDict == nil {
                FirebaseHelper.fetchDatas(path: path)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .observeOn(MainScheduler.asyncInstance)
                    .subscribe(onNext: { congressDict in
                        Congress.congressDict = congressDict
                        
                    }, onError: { error in
                        errorHandler(error)
                    }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                    }).disposed(by: rx.disposeBag)
                return
            }
        case .guMayor:
            path = .guMayor
            if Congress.guMayorDict == nil {
                FirebaseHelper.fetchDatas(path: path)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .observeOn(MainScheduler.asyncInstance)
                    .subscribe(onNext: { guMayorDict in
                        Congress.guMayorDict = guMayorDict
                        
                    }, onError: { error in
                        errorHandler(error)
                    }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                    }).disposed(by: rx.disposeBag)
                return
            }
        case .siCouncil:
            path = .siCouncil
            if Congress.siCouncilDict == nil {
                FirebaseHelper.fetchDatas(path: path)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .observeOn(MainScheduler.asyncInstance)
                    .subscribe(onNext: { siCouncilDict in
                        Congress.siCouncilDict = siCouncilDict
                        
                    }, onError: { error in
                        errorHandler(error)
                    }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                    }).disposed(by: rx.disposeBag)
                return
            }
        case .guCouncil:
            path = .guCouncil
            if Congress.guCouncilDict == nil {
                FirebaseHelper.fetchDatas(path: path)
                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                    .observeOn(MainScheduler.asyncInstance)
                    .subscribe(onNext: { guCouncilDict in
                        Congress.guCouncilDict = guCouncilDict
                        
                    }, onError: { error in
                        errorHandler(error)
                    }, onCompleted: { [weak self] in
                        self?.bindData()
                        completion()
                    }).disposed(by: rx.disposeBag)
                return
            }
        default:
            break
        }
        
//        if Congress.congressDict == nil && electionType == .nationalAssembly {
//            FirebaseHelper.fetchDatas(path: path)
//                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//                .observeOn(MainScheduler.asyncInstance)
//                .subscribe(onNext: { congress in
//                    Congress.congressDict = congress
//
//                    }, onCompleted: { [weak self] in
//                        self?.bindData()
//                        completion()
//                }).disposed(by: rx.disposeBag)
//            return
//        }
        
        bindData()
        completion()
    }
    
    func bindData() {
        setCongressCandidateList()
    }
    
    func setCongressCandidateList() {
        var congresses: NSDictionary? = nil
        switch electionType {
        case .nationalAssembly:
            congresses = Congress.congressDict
        case .guMayor:
            congresses = Congress.guMayorDict
        case .siCouncil:
            congresses = Congress.siCouncilDict
        case .guCouncil:
            congresses = Congress.guCouncilDict
        default:
            break
        }
        
        guard let electionDict = congresses,
            let candidates = electionDict.value(forKey: self.electionName.getElectionName(electionType: electionType)) as? [NSDictionary],
            let data = try? JSONSerialization.data(withJSONObject: candidates, options: .prettyPrinted) else {
                congressCandidateList.removeAll()
                return
        }
//        let data = NSKeyedArchiver.archivedData(withRootObject: candidates)
//        let data = Data(candidates)
        congressCandidateList.removeAll()
        
        if let candidateList = try? JSONDecoder().decode([Candidate].self, from: data) {
            congressCandidateList.append(contentsOf: candidateList)
            congressCandidateList.sort {
                guard let first = $0.number, let second = $1.number,
                let firstNumber = Int(first), let secondNumber = Int(second) else { return true }
                return firstNumber < secondNumber
            }
        }
    }
    
    func switchElectionType(electionType: ElectionType) {
        self.electionType = electionType
    }
    
    
    func fetchPartyPromise(location: String? = nil, errorHandler: @escaping (Error) -> Void, completion: @escaping () -> Void) {
        if PartyMemory.partyPromiseDict == nil {
            FirebaseHelper.fetchDatas(path: .partyPromise, key: location) .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.asyncInstance)
                .subscribe(onNext: { partyPromise in
                    PartyMemory.partyPromiseDict = partyPromise
                }, onError: { error in
                    errorHandler(error)
                }, onCompleted: { [weak self] in
                        self?.bindPartyPromise()
                        completion()
                }).disposed(by: rx.disposeBag)
            return
        }
        
        bindPartyPromise()
        completion()
    }
    
    func bindPartyPromise() {

        if self.partyPromiseList == nil {
            self.partyPromiseList = [Promise]()
        }
        if let promiseList = PartyMemory.partyPromiseData(name: partyName) {
            self.partyPromiseList?.append(contentsOf: promiseList)
        }
    }
}
