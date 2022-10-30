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
    
    let colletionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
    }
    
    func configureUI() {
        
        [colletionView, searchTextField, validationLabel, searchButton].forEach {
            self.view.addSubview($0)
        }
        
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
        
        colletionView.snp.makeConstraints { make in
            make.top.equalTo(validationLabel.snp.bottom).offset(0)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
}
