//
//  UnsplashViewModel.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/31.
//

import Foundation

class UnsplashViewModel {
    
    var photoList: CObservable<SearchPhoto> = CObservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    
    func requestPhoto(query: String) {
        APIService.searchPhoto(query: query) { photo, statusCode, error in
            guard let photo = photo else { return }
            self.photoList.value = photo
        }
    }
}
