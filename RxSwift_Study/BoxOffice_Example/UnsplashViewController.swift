//
//  UnsplashViewController.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/31.
//

import UIKit

import Kingfisher
import RxCocoa
import RxSwift
import SnapKit
import Then

class UnsplashViewController: UIViewController {
    
    let tableView: UITableView = {
        let view = UITableView.init(frame: .zero, style: .insetGrouped)
        return view
    }()
    
    let searchTextField = UITextField().then {
        $0.placeholder = "이미지를 검색해보세요."
        $0.backgroundColor = .opaqueSeparator
        $0.layer.cornerRadius = 10
    }
    
    let validationLabel = UILabel().then {
        $0.textColor = .systemMint
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textAlignment = .center
    }
    
    let searchButton = UIButton().then {
        $0.setTitle("검색", for: .normal)
        $0.backgroundColor = .systemMint
        $0.layer.cornerRadius = 10
    }
    
    let resetButton = UIBarButtonItem(title: "초기화", style: .plain, target: UnsplashViewController.self, action: nil)

    let viewModel = UnsplashViewModel()
    
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        viewModel.list
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = "\(element.photoDescription)"
            }
            .disposed(by: disposeBag)
        
        viewModel.validText
            .asDriver() //BehaviorRelay와 짝꿍
            .drive(validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        let validation = searchTextField.rx.text
            .orEmpty
            .map { $0.count >= 1}
            .share()
        
        validation
            .bind(to: searchButton.rx.isEnabled, validationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        validation
            .bind { [weak self] value in
                let color: UIColor = value ? .systemMint : .systemGray
                self?.searchButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
        searchButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.viewModel.requestPhoto(query: self.searchTextField.text!)
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.viewModel.resetData()
            }
            .disposed(by: disposeBag)
        
        configureUI()
        setConstraints()
    }
    
    func configureUI() {
        
        [tableView, searchTextField, validationLabel, searchButton].forEach {
            self.view.addSubview($0)
        }
        navigationItem.title = "이미지 검색하기"
        navigationItem.leftBarButtonItem = resetButton
        
    }
    
    func setConstraints() {
        
        searchTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.height.equalTo(44)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(44)
            make.width.equalTo(100)
            make.leading.equalTo(searchTextField.snp.trailing).offset(8)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchTextField.snp.bottom).offset(0)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(0)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
}
