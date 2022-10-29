//
//  BoxOfficeModel.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/30.
//

import Foundation

struct DailyBoxOffice: Codable {
    let rank: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
    
    enum CodingKeys: String, CodingKey {
        case rank
        case movieNm
        case openDt
        case audiAcc
    }
}

struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOffice]
}

struct BoxOfficeResponse: Codable {
    let boxOfficeResult: BoxOfficeResult
}


