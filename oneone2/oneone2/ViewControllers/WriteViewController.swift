//
//  WriteViewController.swift
//  oneone2
//
//  Created by 이윤주 on 11/9/24.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import FloatingPanel


class WriteViewController:UIViewController, CategorySelectDelegate{
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var editContent: UITextField!
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lblCategory: UILabel!
    
    // 다이어리 객체 생성
    var diary: DiaryEntry?
    // 신규인지 수정인지 구분값
    var isNew:Bool = true
    // 뷰모델 인스턴스 생성
    var diaryViewModel = DiaryViewModel()
    var categoryVieModel = CategoryViewModel()
    var category = CategoryEntry(categoryName: "전체", categoryEmoji: "")
    
    // 바텀시트
    var floatingPanel: FloatingPanelController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap gesture recognizer 설정
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        datePicker.datePickerMode = .date
        //isNew=true
        btnAdd.layer.cornerRadius = 10
        // 카테고리 기본 설정 (전체로)
        category.categoryName = "전체"
        category.categoryEmoji = "🔎"
        lblCategory.text = "🔎 전체"
        
        // 카테고리 선택 액션
        // lblCategory에 Tap Gesture 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(setupFloatingPanel))
        lblCategory.isUserInteractionEnabled = true
        lblCategory.addGestureRecognizer(tapGesture)
    
        // 카테고리 바텀 준비
       // setupFloatingPanel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 데이터를 UI에 채워넣기
        if let diary = diary {
            isNew = false
            // diary가 nil이 아닐 때 실행
            print("diary is NOT nil.")
            self.editTitle.text = diary.title
            self.editContent.text = diary.content
            
            lblCategory.text = diary.categoryEmoji + " " + diary.categoryName
            // 원하는 날짜를 생성
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.datePicker.date = formatter.date(from: diary.timestamp)!
            
        } else {
            isNew = true
            // 카테고리 기본 설정 (전체로)
            category.categoryName = "전체"
            category.categoryEmoji = "🔎"
            lblCategory.text = "🔎 전체"
            // diary가 nil일 때 처리
            print("diary is nil.")
        }
    }
    
    // MARK: -Floating Pannel 설정
    @objc func setupFloatingPanel() {
        // FloatingPanelController 생성
        floatingPanel = FloatingPanelController()
        floatingPanel?.layout = CustomFloatingPanelLayout(tabBarHeight: 44)
        view.endEditing(true) 
        // 스토리보드에서 바텀 시트로 사용할 ViewController 가져오기
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "CategoryPopupViewController") as? CategoryPopupViewController else {
            print("CategoryPopupViewController를 찾을 수 없음")
            return
        }
        contentVC.delegate = self
        
        // FloatingPanel에 ViewController 설정
        floatingPanel?.set(contentViewController: contentVC)
        
        // Dim 영역 클릭 시 패널을 닫을 수 있도록 설정
        floatingPanel?.isRemovalInteractionEnabled = true
        
        // FloatingPanel의 cornerRadius 설정
//        floatingPanel?.surfaceView.layer.cornerRadius = 20 // 20은 원하는 라운드 값
//        floatingPanel?.surfaceView.layer.masksToBounds = true // 라운드를 위해 마스크 처리
//        floatingPanel?.surfaceView.layer.shadowColor = UIColor.black.cgColor
//        floatingPanel?.surfaceView.layer.shadowOpacity = 0.1
//        floatingPanel?.surfaceView.layer.shadowOffset = CGSize(width: 0, height: -2)
//        floatingPanel?.surfaceView.layer.shadowRadius = 20
        
        // 바텀 시트 표시
        floatingPanel?.addPanel(toParent: self)
    }
    
    // CategorySelectDelegate 구현
    func didSelectCategory(_category category: CategoryEntry) {
        print("didSelectCategory : ", category.categoryName)
        // 카테고리 객체에 카테고리 뷰에서 가져온 정보 넣기
        self.category.categoryName = category.categoryName
        self.category.categoryEmoji = category.categoryEmoji
        lblCategory.text = category.categoryEmoji + " " + category.categoryName
        
        // FloatingPanel 닫기
        floatingPanel?.dismiss(animated: true, completion: nil)
    }
    
    func addTodoItem() {
        let content = editContent.text
        let title = editTitle.text
        let datePicker = datePicker.date
        let category = lblCategory.text
        print("addTodoItem : ", self.category.categoryName)
        // 날짜를 문자열로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 원하는 포맷으로 설정
        let dateString = dateFormatter.string(from: datePicker)
        
        // 신규작성이면
        if isNew  {
            print("TRUEE")
            diary = DiaryEntry(title: title ?? "", content: content ?? "", timestamp: dateString, diaryId: "", categoryName: self.category.categoryName, categoryEmoji: self.category.categoryEmoji )
            
            if let diary = diary {
                diaryViewModel.newDiary(diary: diary)
            } else {
                print("Error: diary is nil.")
            }

        }
        // 수정이면
        else{
            print("FALSEEEE")
            diary?.content = content ?? ""
            diary?.title = title ?? ""
            diary?.timestamp = dateString
            diary?.categoryName = self.category.categoryName
            diary?.categoryEmoji = self.category.categoryEmoji
            // diaryViewModel.editDiary(diary: diary!)
            if let diary = diary {
                diaryViewModel.editDiary(diary: diary)
            } else {
                print("Error: diary is nil.")
            }
        }
        
       }
    
    
    @IBAction func onTodoAddBtnClicked(_ sender: UIButton) {
        print("**onTodoAddBtnClicked**")
        addTodoItem()
        view.endEditing(true) // 키보드 내리기
        showToast(message: "저장이 완료되었습니다. 😀")
        editContent.text = ""
        editTitle.text = ""
        diary = nil
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // 키보드 내리기
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
                                     y: view.frame.height - 300,
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
