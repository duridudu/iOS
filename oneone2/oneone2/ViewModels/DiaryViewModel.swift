//
//  DiaryViewModel.swift
//  oneone2
//
//  Created by 이윤주 on 11/16/24.
//

import Foundation
class DiaryViewModel {
    private var diaryModel = DiaryModel()
    // 다이어리 항목을 저장할 배열
    private var diaryEntries = [DiaryEntry]()
    // View에서 userId를 받아서 Model에 전달
    func setUserId(_ id: String) {
           diaryModel.setUserId(id)
    }
    
}
