//
//  DiaryViewModel.swift
//  oneone2
//
//  Created by 이윤주 on 11/16/24.
//

import Foundation
class DiaryViewModel {
    
    //private var diaryModel = DiaryModel()
    
    // 다이어리 항목을 저장할 배열
    private var diaryEntries = [DiaryEntry]()
    var notiManager = NotificationManager()
    
    // View에서 userId를 받아서 Model에 전달
    func setUserId(_ id: String) {
        DiaryModel.shared.setUserId(id)
    }
    
    // READ all
    func setAllDiaries(completion: @escaping ([DiaryEntry]) -> Void){
        DiaryModel.shared.fetchAllDiaries { diaries in
            completion(diaries)
        }
    }
    
    // READ each
    func setEachDiaries(for date: Date, completion: @escaping([DiaryEntry])->Void){
        DiaryModel.shared.fetchEachDiaries(for: date){diaries in
            completion(diaries)}
    }
    
    // READ category
    func setCategoryDiaries(for category:String, completion: @escaping([DiaryEntry])->Void){
        DiaryModel.shared.fetchCategoryDiaries(for: category){
            diaries in completion(diaries)
        }
    }
    
    // Update
    func editDiary(diary:DiaryEntry){
        DiaryModel.shared.updateDiary(diary: diary)
    }
    
    // Create
    func newDiary(diary:DiaryEntry){
        DiaryModel.shared.addDiary(diary: diary) { diaryId in
            if diaryId == diaryId {
                // 다이어리 저장 성공 후 알림 설정
                var date = self.convertStringToDate(diary.timestamp) ?? Date()
                print("난 뷰모델. 다이어리 아이디는 ? : ", diaryId)
                self.notiManager.scheduleNotification(for: diary, on: date, diaryId: diaryId)
            } else {
                print("Failed to save diary entry.")
            }
        }
    }
    
    // Delete
    func deleteDiary(diary:DiaryEntry){
        DiaryModel.shared.deleteDiary(diary: diary)
    }
    
    //MARK: -날짜 포메팅
    // Firebase에서 불러온 timestamp string을 Date로 변환
    private func convertStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 저장할 때 사용한 포맷
        return dateFormatter.date(from: dateString)
    }
    
}
