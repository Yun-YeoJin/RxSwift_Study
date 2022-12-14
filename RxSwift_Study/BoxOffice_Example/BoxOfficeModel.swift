//
//  BoxOfficeModel.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/30.
//

import Foundation

struct BoxOfficeResponse: Codable, Hashable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable, Hashable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
}

struct DailyBoxOffice: Codable, Hashable {
    let rank: String
    let movieNm: String
    let openDt: String
    
    enum CodingKeys: String, CodingKey {
        case rank
        case movieNm
        case openDt
    }
}






