//
//  BoxOfficeTableViewCell.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/30.
//

import UIKit

import SnapKit
import Then

class BoxOfficeTableViewCell: UITableViewCell {
    
    let rankLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textAlignment = .center
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textAlignment = .left
        $0.textColor = .label
    }
    
    let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .left
        $0.textColor = .label
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
        
        self.backgroundColor = .clear
        
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [rankLabel, titleLabel, dateLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        
        rankLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(rankLabel.snp.trailing).offset(8)
            make.height.equalTo(15)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(rankLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
            
        }
        
    }
    
    
}

