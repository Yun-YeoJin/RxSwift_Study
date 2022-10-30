//
//  BoxOfficeViewModel.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/30.
//

import Foundation

class BoxOfficeViewModel {
    
    var movieList: CObservable<BoxOfficeResponse> = CObservable(BoxOfficeResponse(boxOfficeResult: BoxOfficeResult(boxofficeType: "일별 박스오피스", showRange: "20221029~20221029", dailyBoxOfficeList: [])))
                                                                
    func requestMovieList(date: String) {
        
        APIService.requestMovie(date: date) { movieList, statusCode, error in
            
            guard let movieList = movieList else { return }
            self.movieList.value = movieList
        }
        
    }
    
    
}
