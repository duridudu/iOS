//
//  Category+Extension.swift
//  oneone2
//
//  Created by 이윤주 on 11/18/24.
//

import Foundation
import UIKit

extension CategoryPopupViewController{
    
    
    // 테이블뷰 셀 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("CATEGORY_CELL_EXTENSION", categoryEntries.count)
            return categoryEntries.count
    }
        
    // 각 셀을 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            
        let category = categoryEntries[indexPath.row]
        cell.configure(with: category, isList:true)
        
        // auto layout 설정
//        cell.translatesAutoresizingMaskIntoConstraints = false
//        cell.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
//        cell.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        
        
        // 버튼 클릭 시 실행될 클로저 설정
        cell.buttonActionClosure = { [weak self] in
        // 버튼 클릭 시 처리할 동작
        print("카테고리 선택됨! IndexPath: \(category.categoryName)")
        // 선택 액션
        self?.delegate?.didSelectCategory(_category: category)
        self?.dismiss(animated: true) // 바텀시트 닫기
    }
            return cell
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 75 // 원하는 셀 높이로 설정 (예: 80 포인트)
        }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView() // 섹션 간의 빈 뷰
        }
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 10 // 셀 간의 여백을 위해 섹션 풋터에 높이 설정
        }
        
        func tableView(_ tableView: UITableView, layoutMarginsForSection section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0) // 셀 위아래 여백
        }
    
}
