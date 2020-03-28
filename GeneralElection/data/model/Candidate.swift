//
//  Candidate.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/25.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import Foundation

struct Candidate: Decodable {
    var address: String?
    var age: String?
    var career: String?
    var criminal: String?
    var district: String?
    var education: String?
    var gender: String?
    var id: String?
    var imageUrl: String?
    var job: String?
    var military: String?
    var name: String?
    var nameFull: String?
    var number: String?
    var party: String?
    var property: String?
    var regCount: String?
    var si: String?
    var status: String?
    var taxArrears: String?
    var taxArrears5: String?
    var taxPayment: String?
    
    private enum CodingKeys: String, CodingKey {
        case address = "Address"
        case age = "Age"
        case career = "Career"
        case criminal = "Criminal"
        case district = "District"
        case education = "Education"
        case gender = "Gender"
        case id = "Id"
        case imageUrl = "ImageUrl"
        case job = "Job"
        case military = "Military"
        case name = "Name"
        case nameFull = "NameFull"
        case number = "Number"
        case party = "Party"
        case property = "Property"
        case regCount = "RegCount"
        case si = "Si"
        case status = "Status"
        case taxArrears = "TaxArrears"
        case taxArrears5 = "TaxArrears5"
        case taxPayment = "TaxPayment"
    }
}
