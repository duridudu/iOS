//
//  ListViewController+Extension.swift
//  oneone2
//
//  Created by 이윤주 on 11/9/24.
//

import Foundation
import UIKit
extension ListViewController{
    
    // 테이블뷰 셀 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("CELL_EXTENSION", diaryEntries.count)
            return diaryEntries.count
    }
        
    // 각 셀을 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
            
            let diary = diaryEntries[indexPath.row]
            cell.configure(with: diary, isList:true)
        // 삭제 버튼이 클릭되었을 때 해당 셀을 삭제
        cell.deleteButtonTapped2 = {
            self.deleteDiary(at: indexPath)
        }
        
        // 버튼 클릭 시 실행될 클로저 설정
        cell.buttonActionClosure = { [weak self] in
            // 버튼 클릭 시 처리할 동작
            print("버튼 클릭됨! IndexPath: \(indexPath)")
            guard let tabBarController = self?.tabBarController else { return }
                
            // 두 번째 탭의 뷰 컨트롤러에 접근
            if let secondTabVC = tabBarController.viewControllers?[1] as? WriteViewController {
                // 데이터 전달
                secondTabVC.diary = diary
                print("MOVE22", diary)     // 두 번째 탭으로 이동
                    tabBarController.selectedIndex = 1
                }
            
        }
        
        
            return cell
        }
    
    // 셀 삭제 처리
    func deleteDiary(at indexPath: IndexPath) {
            let diary = diaryEntries[indexPath.row]
            
            // Firebase에서 해당 다이어리 삭제
            deleteDiaryEntryFromFirebase(diary: diary)
            
            // 배열에서 삭제
            diaryEntries.remove(at: indexPath.row)
            
            // 테이블 뷰에서 해당 셀 삭제
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    
    // 셀 클릭 이벤트
    // UITableViewDelegate 메서드 추가
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        // 선택된 셀의 데이터 가져오기
        let selectedDiary = diaryEntries[indexPath.row]
        
        guard let tabBarController = self.tabBarController else { return }
            
        // 두 번째 탭의 뷰 컨트롤러에 접근
        if let secondTabVC = tabBarController.viewControllers?[1] as? WriteViewController {
            // 데이터 전달
            secondTabVC.diary = selectedDiary
            print("MOVE22", selectedDiary)     // 두 번째 탭으로 이동
                tabBarController.selectedIndex = 1
            }
       
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
