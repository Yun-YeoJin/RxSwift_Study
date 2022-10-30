//
//  BoxOfficeViewController.swift
//  RxSwift_Study
//
//  Created by 윤여진 on 2022/10/30.
//

import UIKit

import RxCocoa
import RxSwift

class BoxOfficeViewController: UIViewController {
    
    let mainView = BoxOfficeView()
    
    let viewModel = BoxOfficeViewModel()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestMovieList(date: "20221012")
        
        setTableView()
        
    }
    
    func setTableView() {
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        items
            .bind(to: mainView.tableView.rx.items) { tableView, row, element in
                let cell = tableView.dequeueReusableCell(withIdentifier: "BoxOfficeTableViewCell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        mainView.tableView.rx.modelSelected(String.self) //items가 String이라서
            .map { data in
                "\(data)를 클릭했습니다."
            }
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.showAlert(title: "RxSwift", message: "신기방기", buttonTitle: "확인") { action in
                    
                }
            })
            .disposed(by: disposeBag)
        
       
    }
    
    
    
}
