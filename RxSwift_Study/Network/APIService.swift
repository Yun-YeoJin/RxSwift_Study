//
//  APIService.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/30.
//

import Foundation
import Alamofire

class APIService {
    
    private init() { }
    
    static func requestMovie(date: String, completion: @escaping (BoxOfficeResponse?, Int?, Error?) -> Void) {
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.boxOffice)&targetDt=\(date)"
        
        AF.request(url, method: .get).responseDecodable(of: BoxOfficeResponse.self) { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value): completion(value, statusCode, nil)
            case .failure(let error): completion(nil, statusCode, error)
            }
            //dump(response)
        }
    }
    
    static func searchPhoto(query: String, completion: @escaping (SearchPhoto?, Int?, Error?) -> Void) {
        let url = "\(EndPoint.searchPhotoURL)\(query)"
        let header: HTTPHeaders = ["Authorization": APIKey.unsplash]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: SearchPhoto.self) { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value): completion(value, statusCode, nil)
            case .failure(let error): completion(nil, statusCode, error)
            }
            dump(response)
        
            
        }
    }
    
}
