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
import FloatingPanel

class ListViewController:UIViewController, UITableViewDataSource, UITableViewDelegate,CategorySelectDelegate  {
    
    // 뷰모델 인스턴스 생성
    var diaryViewModel = DiaryViewModel()
    var diaryEntries = [DiaryEntry]()
    
    @IBOutlet var tableView: UITableView!
    
    // 바텀시트
    var floatingPanel: FloatingPanelController?
    var category: CategoryEntry?
    var button:UIButton!
    
    override func viewDidLoad() {
        // 테이블뷰 설정
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10) // 테이블뷰 상단, 좌우 여백 10 포인트
        tableView.allowsSelection = true
        
        // 비동기 처리
        diaryViewModel.setAllDiaries{ [weak self] diaries in
            DispatchQueue.main.async {
                self?.diaryEntries = diaries
                print("self?.diaryEntries : ", diaries)
                self?.tableView.reloadData()
            }
        }
        
        // 카테고리 버튼 추가
        // 버튼 추가
        button = UIButton(type: .system)
        button.setTitle("🔎 전체", for: .normal)
        button.titleLabel?.font = UIFont(name: "NoonnuBasicGothicRegular", size: 22)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
        // 버튼의 크기 및 위치 설정
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
            
        // 버튼을 테이블 뷰 헤더에 추가
        tableView.tableHeaderView = button
        
        
       // self.tableView.reloadData()
    }
    
    @objc func buttonTapped() {
        print("Button was tapped!")
        // FloatingPanelController 생성
        floatingPanel = FloatingPanelController()

        // 스토리보드에서 바텀 시트로 사용할 ViewController 가져오기
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "CategoryPopupViewController") as? CategoryPopupViewController else {
            print("CategoryPopupViewController를 찾을 수 없음")
            return
        }
        contentVC.delegate = self
        // FloatingPanel에 ViewController 설정
        floatingPanel?.set(contentViewController: contentVC)
        floatingPanel?.isRemovalInteractionEnabled = true

        // 바텀 시트 표시
        present(floatingPanel!, animated: true, completion: nil)
        //floatingPanel?.addPanel(toParent: self)
    }
    
    
    // 탭바 왔다갔다 할 때 계속 갱신되어야함
    override func viewWillAppear(_ animated: Bool) {
        // 비동기 처리
        if button.title(for: .normal) == "🔎 전체" {
            setAll()
        }
        else{
            let tempTitle = button.title(for: .normal)
            setSelected(category: String(tempTitle!.split(separator: " ")[1]))
        }
        
        
    }
    
    // AViewControllerDelegate 구현
    func didSelectCategory(_category category: CategoryEntry) {
        // 카테고리 객체에 카테고리 뷰에서 가져온 정보 넣기
        self.category?.categoryName = category.categoryName
        self.category?.categoryEmoji = category.categoryEmoji
        
        // FloatingPanel 닫기
        floatingPanel?.dismiss(animated: true, completion: nil)
        // button title 바꿔주기
        button.setTitle(category.categoryEmoji + " " + category.categoryName, for: .normal)
        // 카테고리 별 데이터 정렬
        // 비동기 처리
        print("선택된 카테고리 ", category.categoryName)
        if category.categoryName == "전체" {
            setAll()
        }else{
            setSelected(category: category.categoryName)
        }
        
    }
    
    func setAll(){
        diaryViewModel.setAllDiaries() { [weak self] diaries in
            DispatchQueue.main.async {
                self?.diaryEntries = diaries
                self?.tableView.reloadData()
                print("Set Category Event 다이어리 count : ", self?.diaryEntries.count ?? "")
            }
        }
    }
    
    func setSelected(category:String){
        diaryViewModel.setCategoryDiaries(for: category) { [weak self] diaries in
            DispatchQueue.main.async {
                self?.diaryEntries = diaries
                self?.tableView.reloadData()
                print("Set Category Event 다이어리 count : ", self?.diaryEntries.count ?? "")
            }
        }
    }
    
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

}
