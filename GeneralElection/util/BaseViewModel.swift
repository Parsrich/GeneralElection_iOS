//
//  BaseViewModel.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import RxSwift
import NSObject_Rx
import Firebase

enum FirestoreCollectionName: String {
    case candidate
    case district
}

class BaseViewModel: NSObject {
    
    let db = Firestore.firestore()
    
    required override init() {
        super.init()
    }
    
//    func setup() {
//        collectionReference(collectionName: FirestoreCollectionName.candidate)
//            .getDocuments(completion: { query, error in
//            if let error = error {
//                print("Error: \(error)")
//            } else {
//                for document in query!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        })
//    }

    func collectionReference(collectionName: FirestoreCollectionName) -> CollectionReference {
        return self.db.collection(collectionName.rawValue)
    }
    
    func getDocuments(in collectionName: FirestoreCollectionName, errorHandler: @escaping (Error) -> Void, completionHandler: @escaping (QuerySnapshot?) -> Void) {
        collectionReference(collectionName: collectionName)
            .whereField("Si", in: ["서울특별시"])
            .getDocuments { querySnapshot, error in
                if let error = error {
                    errorHandler(error)
                } else {
                    completionHandler(querySnapshot)
                }
        }
    }
    
    func whereField(reference: CollectionReference, _ field: String, in values: [Any]) -> Query {
        return reference.whereField(field, in: values)
    }
}
