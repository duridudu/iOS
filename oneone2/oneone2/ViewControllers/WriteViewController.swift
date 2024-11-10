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

class WriteViewController:UIViewController{
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var editContent: UITextField!
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var ref: DatabaseReference!
    var diary: DiaryEntry?
    var isNew:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference() // Firebase 데이터베이스 초기화
        
        // Tap gesture recognizer 설정
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        //isNew=true
        btnAdd.layer.cornerRadius = 10
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 데이터를 UI에 채워넣기
        if let diary = diary {
            isNew = false
            // diary가 nil이 아닐 때 실행
            print("diary is NOT nil.")
            self.editTitle.text = diary.title
            self.editContent.text = diary.content
        } else {
            isNew = true
            // diary가 nil일 때 처리
            print("diary is nil.")
        }
    }
    
  
    func addTodoItem() {
        let content = editContent.text
        let title = editTitle.text
        let datePicker = datePicker.date
        
        // 날짜를 문자열로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 원하는 포맷으로 설정
        let dateString = dateFormatter.string(from: datePicker)
        
        guard let userId = Auth.auth().currentUser?.uid else {
                    print("User not logged in")
                    return
        }
        
        print("USER ID",userId)
       
//        userDiaryRef.setValue(["title": title, "content":content, "timestamp" :dateString,  "photourl":"url", "diaryId":userDiaryRef.key]) { error, _ in
//            if let error = error {
//                print("Error saving diary entry: \(error)")
//            } else {
//                print("Diary entry saved successfully!")
//            }
//        }
        // 신규작성이면
        if isNew  {
            print("TRUEE")
            // 사용자 경로에 diaries 항목 추가
            let userDiaryRef = ref.child("users").child(userId).child("diaries").childByAutoId()
            userDiaryRef.setValue(["title": title, "content":content, "timestamp" :dateString,  "photourl":"url", "diaryId":userDiaryRef.key]) { error, _ in
                if let error = error {
                    print("Error saving diary entry: \(error)")
                } else {
                    print("Diary entry saved successfully!")
                }
            }
        }
        // 수정이면
        else{
            print("FALSEEEE")
            // 사용자 경로에 diaries 항목 추가
            let userDiaryRef = ref.child("users").child(userId).child("diaries").child(diary?.diaryId ?? "")
            userDiaryRef.updateChildValues([
                    "title": title ?? "",
                    "content": content ?? "",
                    "timestamp": dateString,
                    "photourl": "url", // 필요에 따라 수정
                ]) { error, _ in
                    if let error = error {
                        print("Error updating diary entry: \(error)")
                    } else {
                        print("Diary entry updated successfully!")
                    }
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
        toastLabel.font = UIFont(name:"눈누 기초고딕 Regular", size:10)
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
