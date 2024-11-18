//
//  TodoTableViewCell.swift
//  oneone2
//
//  Created by 이윤주 on 11/9/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UITextView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnDelete2: UIButton!
    
    @IBOutlet weak var lblTitle2: UITextView!
    @IBOutlet weak var lblDate2: UITextView!
    @IBOutlet weak var lblDate: UITextView!
    
    @IBOutlet weak var lblEmoji: UILabel!
    @IBOutlet weak var lblEmoji2: UILabel!
    
    // 삭제 버튼 클릭 시 호출될 메서드
    var deleteButtonTapped: (() -> Void)?
    var deleteButtonTapped2: (() -> Void)?
    // 버튼 클릭 시 호출되는 클로저
    var buttonActionClosure: (() -> Void)?
    
    func configure(with diary: DiaryEntry, isList:Bool) {
        // 날짜 표시
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 날짜 형식 설정
        
        // lblTitle과 lblDate에 값 설정
        if isList {
            lblTitle.text = diary.title
            lblDate.text = diary.timestamp
            lblTitle.font = UIFont(name: "NoonnuBasicGothicRegular", size: 16)
            lblDate.font = UIFont(name: "NoonnuBasicGothicRegular", size: 12)
            // 이모지 표시 설정
            lblEmoji2.layer.cornerRadius = lblEmoji2.frame.height / 2
            lblEmoji2.clipsToBounds = true
            lblEmoji2.text = diary.categoryEmoji
        }
        else{
            lblTitle2.text = diary.title
            lblDate2.text = diary.timestamp
            lblTitle2.font = UIFont(name: "NoonnuBasicGothicRegular", size: 16)
            lblDate2.font = UIFont(name: "NoonnuBasicGothicRegular", size: 14)
            // 이모지 표시 설정
            lblEmoji.layer.cornerRadius = lblEmoji.frame.height / 2
            lblEmoji.clipsToBounds = true
            lblEmoji.text = diary.categoryEmoji
        }
        
        // 셀의 테두리 설정
//         self.layer.borderColor = UIColor.mainColor.cgColor // 테두리 색상 설정
//         self.layer.borderWidth = 2.0 // 테두리 두께 설정
//         self.layer.cornerRadius = 8.0 // 모서리 둥글게 설정 (선택 사항)
//         self.layer.masksToBounds = true // 둥근 테두리 적용
//        
      
        // 셀 내부 여백 설정
       //self.contentView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // 원하는 여백 값으로 설정
       // self.contentView.preservesSuperviewLayoutMargins = false // 부모 뷰 여백 유지 여부 설정
        
    }
    

    @IBAction func onBtnDeleteClickd(_ sender: UIButton) {
        deleteButtonTapped?()
    }
    @IBAction func onBtnDelte2Clicked(_ sender: UIButton) {
        deleteButtonTapped2?()
    }
    
    @IBAction func onBtnCellClicked(_ sender: UIButton) {
        buttonActionClosure?()

    }
    
    @IBAction func onBtnCellClicked2(_ sender: UIButton) {
        buttonActionClosure?()
    }
    
    
    
}
