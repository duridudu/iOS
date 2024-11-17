//
//  ListViewController.swift
//  oneone2
//
//  Created by 이윤주 on 11/9/24.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class ListViewController:UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    // 뷰모델 인스턴스 생성
    var diaryViewModel = DiaryViewModel()
    var diaryEntries = [DiaryEntry]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        // 테이블뷰 설정
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10) // 테이블뷰 상단, 좌우 여백 10 포인트
        tableView.allowsSelection = true
        
        // 비동기 처리
        diaryViewModel.setAllDiaries{ [weak self] diaries in
            DispatchQueue.main.async {
                self?.diaryEntries = diaries
                print("self?.diaryEntries : ", diaries)
                self?.tableView.reloadData()
            }
        }
        
       // self.tableView.reloadData()
    }
    
    
    // 탭바 왔다갔다 할 때 계속 갱신되어야함
    override func viewWillAppear(_ animated: Bool) {
        // 비동기 처리
        diaryViewModel.setAllDiaries{ [weak self] diaries in
            DispatchQueue.main.async {
                self?.diaryEntries = diaries
                self?.tableView.reloadData()
            }
        }
    }
    
//    private func setEvents(){
//        let userId = Auth.auth().currentUser?.uid ?? ""
//        let diariesRef = Database.database().reference().child("users/\(userId)/diaries")
//        
//        diariesRef.observeSingleEvent(of: .value) { snapshot in
//            var entries = [DiaryEntry]()
//            
//            for child in snapshot.children {
//                if let snapshot = child as? DataSnapshot,
//                   let diaryData = snapshot.value as? [String: Any] {
//                    
//                    let title = diaryData["title"] as? String ?? ""
//                    let content = diaryData["content"] as? String ?? ""
//                    let timestampString = diaryData["timestamp"] as? String ?? ""
//                    let diaryId = diaryData["diaryId"] as? String ?? ""
//                    
//                    print("TABLE", title)
//                    if let timestamp = self.convertStringToDate(timestampString) {
//                        let newEntry = DiaryEntry(title: title, content: content, timestamp: timestamp, diaryId:diaryId)
//                        entries.append(newEntry)
//                    }
//                }
//            }
//            
//            // 불러온 다이어리 데이터를 배열에 저장
//            self.diaryEntries = entries
//            self.tableView.reloadData()
//           // self.calendar.reloadData() // 캘린더를 새로고침하여 데이터 표시
//            
//        }
//        
//    }
    
    // 날짜 문자열을 Date 객체로 변환하는 함수
    func convertStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 저장된 형식에 맞추기
        return dateFormatter.date(from: dateString)
    }
    
    
    
    func showToast(message: String, duration: Double = 2.0) {
           // 토스트 메시지의 라벨 생성
           let toastLabel = UILabel()
           toastLabel.text = message
        toastLabel.font = UIFont(name:"NoonnuBasicGothicRegular", size:10)
           toastLabel.textColor = .white
           toastLabel.textAlignment = .center
           toastLabel.numberOfLines = 0
           
           // 라벨 배경과 스타일 설정
           toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
           toastLabel.layer.cornerRadius = 10
           toastLabel.clipsToBounds = true
           
           // 라벨 위치와 크기 설정
           let textSize = toastLabel.intrinsicContentSize
           let labelWidth = min(textSize.width + 40, view.frame.width - 40)
           let labelHeight = textSize.height + 20
           toastLabel.frame = CGRect(x: (view.frame.width - labelWidth) / 2,
                                     y: view.frame.height - 260,
                                     width: labelWidth,
                                     height: labelHeight)
           
           // 토스트 메시지를 뷰에 추가하고 애니메이션으로 나타나게 하기
           view.addSubview(toastLabel)
           UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
               toastLabel.alpha = 0.0
           }) { _ in
               toastLabel.removeFromSuperview() // 애니메이션 종료 후 제거
           }
       }
    
    
//    // Firebase에서 다이어리 삭제하는 메서드
//    func deleteDiaryEntryFromFirebase(diary: DiaryEntry) {
//        let userId = Auth.auth().currentUser?.uid ?? ""
//        let diaryRef = Database.database().reference().child("users/\(userId)/diaries")
//            
//        // diaryId로 해당 항목을 찾아서 삭제
//           let query = diaryRef.queryOrdered(byChild: "diaryId").queryEqual(toValue: diary.diaryId) // diaryId를 사용하여 쿼리
//           
//           query.observeSingleEvent(of: .value) { snapshot in
//               if let snapshot = snapshot.children.allObjects.first as? DataSnapshot {
//                   // diaryId에 해당하는 항목을 삭제
//                   snapshot.ref.removeValue { error, _ in
//                       if let error = error {
//                           print("Error deleting diary: \(error.localizedDescription)")
//                       } else {
//                           self.showToast(message: "삭제되었습니다.")
//                           // 삭제 후 바로 없어진거 보여주려고
//                           self.setEvents()
//                           print("Diary deleted successfully!")
//                       }
//                   }
//               }
//           }
//        }
}
