//
//  UnsplashViewModel.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/31.
//

import Foundation

import RxCocoa
import RxSwift

class UnsplashViewModel {
    
    var photoList: CObservable<SearchPhoto> = CObservable(SearchPhoto(total: 0, totalPages: 0, results: []))
    
    func requestPhoto(query: String) {
        APIService.searchPhoto(query: query) { photo, statusCode, error in
            guard let photo = photo else { return }
            self.photoList.value = photo
        }
    }
    
    var list = BehaviorSubject<[SearchResult]>(value: [])
    
    func resetData() {
        list.onNext([])
    }
    
    let validText = BehaviorRelay(value: "최소 1글자 이상(영어만) 입력해주세요.")
    
}
