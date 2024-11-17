//
//  DiaryModel.swift
//  oneone2
//
//  Created by 이윤주 on 11/16/24.
//

import FSCalendar
import FirebaseAuth
import FirebaseDatabase

class DiaryModel {

    private var userId: String?
    private var diariesRef:DatabaseReference?
    var diaryEntries = [DiaryEntry]()
    
    static let shared = DiaryModel() // 싱글턴 인스턴스
    private init() {} // 외부에서 인스턴스를 생성하지 못하도록 설정
    
    // userId를 설정하는 메서드
    func setUserId(_ id: String) {
        self.userId = id
        self.diariesRef = Database.database().reference().child("users/\(String(describing: userId))/diaries")
    }
       
    //MARK: -READ ALL
    func fetchAllDiaries(completion: @escaping ([DiaryEntry]) -> Void) {
        print("---SET EVENTS---")
        if let diariesRef = diariesRef {
            diariesRef.observe(.value) { snapshot in
                // snapshot 처리
                var entries = [DiaryEntry]()
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                       let diaryData = snapshot.value as? [String: Any] {
                        
                        let title = diaryData["title"] as? String ?? ""
                      //  print("title : ", title)
                        let content = diaryData["content"] as? String ?? ""
                        let timestampString = diaryData["timestamp"] as? String ?? ""
                        let diaryId = diaryData["diaryId"] as? String ?? ""
                        if self.convertStringToDate(timestampString) != nil {
                            let newEntry = DiaryEntry(title: title, content: content, timestamp: timestampString, diaryId: diaryId)
                            entries.append(newEntry)
                        }
                    }
                }
                // 불러온 다이어리 데이터를 배열에 저장
                self.diaryEntries = entries
                print("끝, 개수는? ", entries.count)
                completion(self.diaryEntries) // 데이터를 콜백으로 전달
            }
        } else {
            print("Error: diariesRef is nil")
        }
        
    }
    
    //MARK: -READ2
    func fetchEachDiaries(for date: Date, completion: @escaping ([DiaryEntry]) -> Void) {
        
        // 날짜를 "yyyy-MM-dd" 형식의 문자열로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if let diariesRef = diariesRef {
            // 특정 날짜에 해당하는 데이터만 가져오는 쿼리
            let query = diariesRef.queryOrdered(byChild: "timestamp").queryEqual(toValue: dateString)
            query.observeSingleEvent(of: .value) { snapshot in
                   var entries = [DiaryEntry]()
                   
                   for child in snapshot.children {
                       if let snapshot = child as? DataSnapshot,
                          let diaryData = snapshot.value as? [String: Any] {
                           
                           let title = diaryData["title"] as? String ?? ""
                           let content = diaryData["content"] as? String ?? ""
                           let timestampString = diaryData["timestamp"] as? String ?? ""
                           let diaryId = diaryData["diaryId"] as? String ?? ""
                           // 날짜 형식 변환
                           if self.convertStringToDate(timestampString) != nil {
                               let newEntry = DiaryEntry(title: title, content: content, timestamp: timestampString, diaryId: diaryId)
                               entries.append(newEntry)
                           }
                       }
                   }
                   
                // 불러온 다이어리 데이터를 배열에 저장
                self.diaryEntries = entries
                // 콜백으로 결과 반환
                completion(self.diaryEntries)
                  
               }
            
        }else {
            print("Error: diariesRef is nil")
        }
      
       
    }
    
    // MARK: -CREATE
    // 사용자 경로에 diaries 항목 추가
    func addDiary(diary: DiaryEntry){
        let userDiaryRef = //diariesRef?.child("users").child(userId!).child("diaries").childByAutoId()
        diariesRef?.childByAutoId()
        userDiaryRef?.setValue(["title": diary.title, "content":diary.content, "timestamp" :diary.timestamp, "photourl":"url", "diaryId":userDiaryRef?.key ?? ""]) { error, _ in
            if let error = error {
                print("Error saving diary entry: \(error)")
            } else {
                print("Diary entry saved successfully!")
            }
        }
    }
   
    
    
    // MARK: -UPDATE
    func updateDiary(diary: DiaryEntry){
        // 사용자 경로에 diaries 항목 추가
        let userDiaryRef = diariesRef?.child(diary.diaryId)
        userDiaryRef?.updateChildValues([
            "title": diary.title,
            "content": diary.content,
            "timestamp": diary.timestamp,
            "photourl": "url" // 필요에 따라 수정
            ]) { error, _ in
                if let error = error {
                    print("Error updating diary entry: \(error)")
                } else {
                    print("Diary entry updated successfully!")
                }
        }
    }
    
    
    
    // MARK: -DELETE
    // Firebase에서 다이어리 삭제하는 메서드
    func deleteDiary(diary: DiaryEntry) {
     
        // diaryId로 해당 항목을 찾아서 삭제
        let query = diariesRef?.queryOrdered(byChild: "diaryId").queryEqual(toValue: diary.diaryId) // diaryId를 사용하여 쿼리
           
        query?.observeSingleEvent(of: .value) { snapshot in
               if let snapshot = snapshot.children.allObjects.first as? DataSnapshot {
                   // diaryId에 해당하는 항목을 삭제
                   snapshot.ref.removeValue { error, _ in
                       if let error = error {
                           print("Error deleting diary: \(error.localizedDescription)")
                       } else {
                           //self.showToast(message: "삭제되었습니다.")
                           // 삭제 후 바로 없어진거 보여주려고
                          // self.setEvents()
                           print("Diary deleted successfully!")
                       }
                   }
               }
           }
        }
 
    //MARK: -날짜 포메팅
    // Firebase에서 불러온 timestamp string을 Date로 변환
    private func convertStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 저장할 때 사용한 포맷
        return dateFormatter.date(from: dateString)
    }
}

