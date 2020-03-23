//
//  FirebaseUsage.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/19.
//  Copyright © 2020 Parsrich. All rights reserved.
//
import UIKit
import RxSwift
import FirebaseDatabase

class FirebaseHelper: NSObject {
    
    static func fetchDatas(path: DatabasePath, location: String? = nil) -> Observable<NSDictionary> {
        return Observable.create { emitter -> Disposable in
            
            var dbReference = FirebaseManager.share.firebaseDB(path: path)
            
            if let location = location {
                dbReference = dbReference.child(location)
            }
            
            dbReference.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dict = snapshot.value as? NSDictionary else { return }
                
                emitter.onNext(dict)
                
                emitter.onCompleted()
            }) { error in
                print(error.localizedDescription)
            }
            return Disposables.create()
        }
    }
}
