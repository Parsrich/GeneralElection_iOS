//
//  Party.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/18.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

class Party: Decodable {
    var name: String?
    var logoImg: String?
    var websiteUrl: String?
    var birye: [Int]?
}

class PartyColor {
    
    static let partyColors: [String: String] = [
    "더불어민주당": "#53779E",//"#004FA2",
    "미래통합당": "#FF5B63",//"#F0426F",
    "민생당": "#4C7354",//"#0AA95F",
    "미래한국당": "#F2959F",//"#B01B64",
    "더불어시민당": "#5F9EAF",//"#0089D3",
    "정의당": "#FFBC2C",//"#FFCC01",
    "우리공화당": "#51957A",//"#009944",
    "국민의당": "#FF8F3C",//"#EA5504",
    "기독자유통일당": "#DA4D40",//"#0075C3",
    "친박신당": "#708E4B",//"#E30010",
    "민중당": "#F26623",
    "열린민주당": "#003E9B",
    "국가혁명배당금당": "#E8141A",
    "가자코리아": "#603027",
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
    "자유의새벽당": "#101922",
    "정치개혁연합": "#C78665",
    "중소자영업당": "#56BA38",
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
    
    static func getPartyColor(party: String) -> UIColor {
        guard let colorHex = partyColors[party], let color = UIColor(hex: colorHex) else { return UIColor(white: 0.5, alpha: 0.8) }
        
        return color
    }
    
}
