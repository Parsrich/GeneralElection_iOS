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
    var name: String?
    var party: String?
    var regDate: String?
    var si: String?
    var status: String?
    
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
        case name = "Name"
        case party = "Party"
        case regDate = "RegDate"
        case si = "Si"
        case status = "Status"
    }
}
