//
//  LoginViewModel.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/11/06.
//

import Foundation

import RxCocoa
import RxSwift

protocol CommonViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class LoginViewModel: CommonViewModel {
  
    struct Input {
        let idText: ControlProperty<String>
        let pwText: ControlProperty<String>
        let loginTap: ControlEvent<Void>
    }
    
    struct Output {
        let idValid: Observable<Bool>
        let pwValid: Observable<Bool>
        let isValid: Observable<Bool>
        let loginTap: ControlEvent<Void>
    }
    
    
    
    func transform(input: Input) -> Output {
        
        let idValid = input.idText
            .map { $0.contains("@") && $0.contains(".") }
            .share()
        
        let pwValid = input.pwText
            .map { $0.count > 5 }
            .share()
        
        var isValid: Observable<Bool> {
            return Observable
                .combineLatest(input.idText, input.pwText)
                .map { email, password in
                    return email.contains("@") && email.contains(".") && password.count > 5
                }
        }
        
        return Output(idValid: idValid, pwValid: pwValid, isValid: isValid, loginTap: input.loginTap)
    }
    
}


