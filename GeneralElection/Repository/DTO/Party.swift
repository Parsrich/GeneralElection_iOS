//
//  Party.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/18.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

struct Party {
    var name: String?
    var websiteUrl: String?
    var number: Int?
    var proportional: [Candidate]?
    var partyPromise: PartyPromise?
    
    init(name: String?, websiteUrl: String?, number: Int?, proportional: [Candidate]?) {
        self.name = name
        self.websiteUrl = websiteUrl
        self.number = number
        self.proportional = proportional
    }
}

struct PartyMemory {
    static var partyPromiseDict: NSDictionary?
    static var partyDict: NSDictionary?
    static var partyList: [String]? {
        return partyDict?.allKeys as? [String]
    }
    
    static var partyDataList: [Party] {
        guard let partyNames = PartyMemory.partyList else { return [Party]() }
        var partyList = [Party]()
        for partyName in partyNames {
            
            if let _ = PartyMemory.partyDict?.value(forKey: partyName) as? String {
                let party = Party(name: partyName, websiteUrl: nil, number: PartySource.getPartyNumber(party: partyName), proportional: nil)

                partyList.append(party)
                continue
            }
            
            guard let candidates = PartyMemory.partyDict?.value(forKey: partyName) as? [NSDictionary],
                let data = try? JSONSerialization.data(withJSONObject: candidates, options: .prettyPrinted) else { continue }
            
            if let candidateList = try? JSONDecoder().decode([Candidate].self, from: data) {
                let party = Party(name: partyName, websiteUrl: nil, number: PartySource.getPartyNumber(party: partyName), proportional: candidateList)

                partyList.append(party)
            }
        }
        partyList.sort { ($0.number ?? 99) < ($1.number ?? 99) }
        
        return partyList
    }
    
    static func partyPromiseData(name: String) -> [Promise]? {
        
        guard let candidates = PartyMemory.partyPromiseDict?.value(forKey: name) as? NSDictionary,
            let data = try? JSONSerialization.data(withJSONObject: candidates, options: []),
            let promise = try? JSONDecoder().decode(PartyPromise.self, from: data) else { return nil }
            
        return promise.promiseList
    }
}

class PartySource {
    
    static let partyColors: [String: String] = [
    "더불어민주당": "#53779E",
    "미래통합당": "#FF5B63",
    "민생당": "#4C7354",
    "미래한국당": "#F2959F",
    "더불어시민당": "#5F9EAF",
    "정의당": "#FFBC2C",
    "우리공화당": "#51957A",
    "국민의당": "#FF8F3C",
    "기독자유통일당": "#DA4D40",
    "친박신당": "#708E4B",
    "민중당": "#F26623",
    "열린민주당": "#003E9B",
    "국가혁명배당금당": "#E8141A",
    "코리아": "#603027",
    "가자!평화인권당": "#0000FF",
    "가자환경당": "#007254",
    "국민새정당": "#1F6DDC",
    "국민참여신당": "#F8C401",
    "공화당": "#D4252B",
    "기독당": "#765192",
    "기본소득당": "#FE8971",
    "깨어있는시민연대당": "#000478",
    "남북통일당": "#ED000C",
    "노동당": "#FF0000",
    "녹색당": "#5DBE3F",
    "대한당": "#4B3293",
    "대한민국당": "#DF9B26",
    "미래당": "#2E3192",
    "미래민주당": "#01A7E7",
    "미래자영업당": "#FFB42F",
    "민중민주당": "#8F2650",
    "사이버모바일국민정책당": "#EF5025",
    "새누리당": "#D91E48",
    "시대전환": "#5A147E",
    "여성의당": "#44009A",
//    "우리당": "#888888",
    "자유당": "#30318B",
    "새벽당": "#101922",
    "자영업당": "#56BA38",
    "직능자영업당": "#752B88",
    "충청의미래당": "#AE469F",
    "친박연대": "#0C449B",
    "통일민주당": "#8FA6A2",
    "통합민주당": "#9ACE32",
    "한국경제당": "#F58229",
    "한국국민당": "#013588",
    "한국복지당": "#EA5404",
    "한나라당": "#D61921",
    "한반도미래연합": "#E33434",
    "홍익당": "##5D173C"
    ]
    
    static let partyNumbers: [String: Int] = [
        "더불어민주당": 1,
        "미래통합당": 2,
        "민생당": 3,
        "미래한국당": 4,
        "더불어시민당": 5,
        "정의당": 6,
        "우리공화당": 7,
        "민중당": 8,
        "한국경제당": 9,
        "국민의당":10,
        "친박신당":11,
        "열린민주당":12,
        "코리아":13,
        "가자!평화인권당":14,
        "가자환경당":15,
        "공화당":16,
        "국가혁명배당금당":17,
        "국민새정당":18,
        "국민참여신당":19,
        "기독당":20,
        "기독자유통일당":21,
        "기본소득당":22,
        "깨어있는시민연대당":23,
        "남북통일당":24,
        "노동당":25,
        "녹색당":26,
        "대한당":27,
        "대한민국당":28,
        "미래당":29,
        "미래민주당":30,
        "미래자영업당":31,
        "민중민주당":32,
        "사이버모바일국민정책당":33,
        "새누리당":34,
        "시대전환":35,
        "여성의당":36,
        "우리당":37,
        "자유당":38,
        "새벽당":39,
        "자영업당":40,
        "직능자영업당":41,
        "충청의미래당":42,
        "친박연대":43,
        "통일민주당":44,
        "통합민주당":45,
        "한국국민당":46,
        "한국복지당":47,
        "한나라당":48,
        "한반도미래연합":49,
        "홍익당": 50
    ]
    
    static let partyProportionalNumber: [String: Int] = [
      "더불어민주당": 0,
      "미래통합당": 0,
      "민생당": 3,
      "미래한국당": 4,
      "더불어시민당": 5,
      "정의당": 6,
      "우리공화당": 7,
      "민중당": 8,
      "한국경제당": 9,
      "국민의당": 10,
      "친박신당": 11,
      "열린민주당": 12,
      "코리아": 13,
      "가자!평화인권당": 14,
      "가자환경당": 15,
      "국가혁명배당금당": 16,
      "국민새정당": 17,
      "국민참여신당": 18,
      "기독자유통일당": 19,
      "깨어있는시민연대당": 20,
      "남북통일당": 21,
      "노동당": 22,
      "녹색당": 23,
      "대한당": 24,
      "대한민국당": 25,
      "미래당": 26,
      "미래민주당": 27,
      "새누리당": 28,
      "여성의당": 29,
      "우리당": 30,
      "자유당": 31,
      "새벽당": 32,
      "자영업당": 33,
      "충청의미래당": 34,
      "한국복지당": 35,
      "통일민주당": 36,
      "홍익당": 37,
      "기독당": 0,
      "기본소득당": 0,
      "미래자영업당": 0,
      "민중민주당": 0,
      "사이버모바일국민정책당": 0,
      "시대전환": 0,
      "자유의새벽당": 0,
      "직능자영업당": 0,
      "친박연대": 0,
      "통합민주당": 0,
      "한국국민당": 0,
      "한나라당": 0,
      "한반도미래연합": 0
    ]

    static let partyWebsites = [String: String]()
    
    static func getPartyColor(party: String) -> UIColor {
        guard let colorHex = partyColors[party], let color = UIColor(hex: colorHex) else { return UIColor(white: 0.5, alpha: 0.8) }
        
        return color
    }

    
    static func getPartyNumber(party: String) -> Int {
        guard let number = partyNumbers[party] else { return 0 }
        
        return number
    }
    
    static func getPartyProportionalNumber(party: String) -> Int {
        guard let number = partyProportionalNumber[party] else { return 0 }
        
        return number
    }
}
