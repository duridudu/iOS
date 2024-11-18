//
//  CategoryTableViewCell.swift
//  oneone2
//
//  Created by 이윤주 on 11/18/24.
//

import Foundation
import UIKit
class CategoryTableViewCell:UITableViewCell{
    
    // 버튼 클릭 시 호출되는 클로저
    var buttonActionClosure: (() -> Void)?
    
    @IBOutlet weak var editEmoji: UILabel!
    @IBOutlet weak var editName: UILabel!
    
    @IBOutlet weak var view: UIView!
    
    func configure(with category: CategoryEntry, isList:Bool) {
        editName.text = category.categoryName
        editEmoji.text = category.categoryEmoji
       
        editName.font = UIFont(name: "NoonnuBasicGothicRegular", size: 14)
        editEmoji.font = UIFont(name: "NoonnuBasicGothicRegular", size: 12)
       
        editEmoji.layer.cornerRadius = editEmoji.frame.height / 2
        editEmoji.clipsToBounds = true
        // 제스처 인식기 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        editName.addGestureRecognizer(tapGesture)
        
        
        // 셀 내부 여백 설정
       //self.contentView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // 원하는 여백 값으로 설정
       // self.contentView.preservesSuperviewLayoutMargins = false // 부모 뷰 여백 유지 여부 설정
        
    }
    
    @objc func labelTapped(){
        buttonActionClosure?()
    }
    
}
