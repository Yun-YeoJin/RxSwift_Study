//
//  BoxOfficeView.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/30.
//

import UIKit

import SnapKit
import Then

class BoxOfficeView: UIView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        return view
    }()
    
    let searchTextField = UITextField().then {
        $0.placeholder = "날짜를 검색하세요. (Ex.20221012)"
        $0.backgroundColor = .lightGray
        $0.textAlignment = .center
        $0.layer.cornerRadius = 20
    }
    
    let searchButton = UIButton().then {
        $0.setTitle("검색", for: .normal)
        $0.backgroundColor = .systemMint
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        [collectionView, searchTextField, searchButton].forEach { self.addSubview($0) }
        
        
    }
    
    func setConstraints() {
        
        searchTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
            make.width.equalTo(100)
            make.leading.equalTo(searchTextField.snp.trailing).offset(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(0)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    
}
