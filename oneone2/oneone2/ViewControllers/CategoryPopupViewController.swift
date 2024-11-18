//
//  CategoryPopupViewController.swift
//  oneone2
//
//  Created by 이윤주 on 11/17/24.
//

import Foundation
import UIKit
//import FloatingPanel

class CategoryPopupViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var btnCategoryAdd: UIButton!
    @IBOutlet weak var tableView: UITableView!
    // 선택한걸 WriteView에 넘겨주기 위함
    weak var delegate: CategorySelectDelegate?
    // 뷰모델, 저장할 배열
    var categoryViewModel = CategoryViewModel()
    var categoryEntries = [CategoryEntry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // 바탕색
        
        // 테이블뷰 설정
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10) // 테이블뷰 상단, 좌우 여백 10 포인트
        tableView.allowsSelection = true
        
        
        btnCategoryAdd.layer.cornerRadius = 10
        
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        setCategories()
    }
    
    func setCategories(){
        // 비동기 처리
        categoryViewModel.setAllCategories{
            [weak self] categories in
                DispatchQueue.main.async {
                    self?.categoryEntries = categories
                    self?.tableView.reloadData()
                }
        }
    }
}
