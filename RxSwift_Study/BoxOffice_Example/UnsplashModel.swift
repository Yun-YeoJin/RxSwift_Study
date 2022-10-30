//
//  UnsplashModel.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/31.
//

import Foundation

struct SearchPhoto: Codable, Hashable {
     
    let total, totalPages: Int
    let results: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct SearchResult: Codable, Hashable {
     
    let id: String
    let urls: Urls
    let likes: Int
    let photoDescription: String

    enum CodingKeys: String, CodingKey {
        case id
        case urls, likes
        case photoDescription = "alt_description"
    }
}

struct Urls: Codable, Hashable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
