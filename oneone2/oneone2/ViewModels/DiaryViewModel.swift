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
        DiaryModel.shared.addDiary(diary: diary)
    }
    
    // Delete
    func deleteDiary(diary:DiaryEntry){
        DiaryModel.shared.deleteDiary(diary: diary)
    }
}
