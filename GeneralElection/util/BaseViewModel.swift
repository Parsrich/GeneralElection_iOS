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
    
    func getDocuments(in collectionName: FirestoreCollectionName,
                      whereFields: [(field: String, conditions: [Any])],
                      errorHandler: @escaping (Error) -> Void,
                      completionHandler: @escaping (QuerySnapshot?) -> Void) {
        
        let reference = collectionReference(collectionName: collectionName)
        
        var query: Query?
        for field in whereFields.enumerated() {
            if field.offset == 0 {
                query = reference
                    .whereField(field.element.field,
                                in: field.element.conditions)
                continue
            }
            query?.whereField(field.element.field, in: field.element.conditions)
        }
                
        query?.getDocuments { querySnapshot, error in
            if let error = error {
                errorHandler(error)
            } else {
                completionHandler(querySnapshot)
            }
        }
    }
    
    func whereField(reference: CollectionReference, _ field: String, in conditions: [Any]) -> Query {
        return reference.whereField(field, in: conditions)
    }
}
