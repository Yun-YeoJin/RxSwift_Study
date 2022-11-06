//
//  LoginViewController.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/11/06.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    let idTextField = UITextField().then {
        $0.placeholder = "E-mail"
        $0.backgroundColor = .systemBackground
    }
    let idValidView = UIView().then {
        $0.backgroundColor = .systemRed
    }
    let pwTextField = UITextField().then {
        $0.placeholder = "PassWord"
        $0.backgroundColor = .systemBackground
    }
    let pwValidView = UIView().then {
        $0.backgroundColor = .systemRed
    }
    let loginButton = UIButton().then {
        $0.setTitle("로그인하기", for: .normal)
        $0.backgroundColor = .systemMint
    }
    
    let viewModel = LoginViewModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
        
        inputOutputBind()
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc func loginButtonClicked() {
            
            let alert = UIAlertController(title: "RxSwift 재밌어요!", message: "어렵기는 하지만..", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(cancel)
            alert.addAction(ok)
            self.present(alert, animated: true)
            
    }
    
    private func configureUI() {
        
        [idTextField, idValidView, pwTextField, pwValidView, loginButton].forEach {
            self.view.addSubview($0)
        }
        
    }
    
    private func setConstraints() {
        
        idTextField.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        idValidView.snp.makeConstraints { make in
            make.trailing.equalTo(idTextField.snp.trailing).inset(8)
            make.top.equalTo(idTextField.snp.top).inset(8)
            make.width.height.equalTo(20)
        }
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        pwValidView.snp.makeConstraints { make in
            make.trailing.equalTo(pwTextField.snp.trailing).inset(8)
            make.top.equalTo(pwTextField.snp.top).inset(8)
            make.width.height.equalTo(20)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        
    }
    
    private func inputOutputBind() {
        
        //MARK: Input, Output
        //Input: 아이디 입력, 비밀번호 입력
        let idInput: ControlProperty<String> = idTextField.rx.text.orEmpty
        let pwInput: ControlProperty<String> = pwTextField.rx.text.orEmpty
        
        let idValid = idInput.map(checkEmailValid) //Bool 타입
        let pwValid = pwInput.map(checkPasswordValid) //Bool 타입
        
        //Output: 빨간 View, 로그인 버튼
        idValid.subscribe { value in
            self.idValidView.isHidden = value
        } onError: { error in
            print(error)
        } .disposed(by: disposeBag)
        
        pwValid.subscribe { value in
            self.pwValidView.isHidden = value
        } onError: { error in
            print(error)
        } .disposed(by: disposeBag)

        Observable.combineLatest(idValid, pwValid, resultSelector: { $0 && $1 })
            .subscribe { value in
                self.loginButton.isEnabled = value
            } onError: { error in
                print(error)
            } .disposed(by: disposeBag)
        
    }

    
    private func bind() {
        
        //MARK: bind()
        idTextField.rx.text.orEmpty //text를 받는다. -> orEmpty : String이 바로 내려옴
            .map(checkEmailValid) // Bool 타입으로 온다.
            .subscribe(onNext: { value in
                self.idValidView.isHidden = value
            })
            .disposed(by: disposeBag)
        
        pwTextField.rx.text.orEmpty //text를 받는다. -> orEmpty : String이 바로 내려옴
            .map(checkPasswordValid) // Bool 타입으로 온다.
            .subscribe(onNext: { value in
                self.pwValidView.isHidden = value
            })
            .disposed(by: disposeBag)
        
        //CombineLatest : Observable 중 하나라도 항목을 배출할 경우에 마지막으로 배출된 항목들을 결합시켜 배출하는 법 (ID, Password)
        //Zip과 비교해보기
        Observable.combineLatest(
            idTextField.rx.text.orEmpty.map(checkEmailValid),
            pwTextField.rx.text.orEmpty.map(checkPasswordValid)) { s1, s2 in
            s1 && s2 //2개의 Stream을 받아서 내려간다.
        }.subscribe { value in
            self.loginButton.isEnabled = value
        }.disposed(by: disposeBag)
        
            
    }
     
    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func checkPasswordValid(_ password: String) -> Bool {
        return password.count > 5
    }
    
}
