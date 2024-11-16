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
    var ref:DatabaseReference!
    //    var diaries: [Date: [String: Any]] = [:]
    //    var diariesByDate: [Date: [DiaryEntry]] = [:]
  
    
    private var userId: String?
       
    // userId를 설정하는 메서드
    func setUserId(_ id: String) {
        self.userId = id
    }
       
   
    private let diariesRef = Database.database().reference().child("users/\(userId)/diaries")
    
    
    //MARK: -READ
    func fetchAllDiaries(){
        print("---SET EVENTS---")
        diariesRef.observeSingleEvent(of: .value) { snapshot in
            var entries = [DiaryEntry]()
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let diaryData = snapshot.value as? [String: Any] {
                    
                    let title = diaryData["title"] as? String ?? ""
                    let content = diaryData["content"] as? String ?? ""
                    let timestampString = diaryData["timestamp"] as? String ?? ""
                    let diaryId = diaryData["diaryId"] as? String ?? ""
                    if let timestamp = self.convertStringToDate(timestampString) {
                        let newEntry = DiaryEntry(title: title, content: content, timestamp: timestamp, diaryId: diaryId)
                        entries.append(newEntry)
                    }
                }
            }
            
            // 불러온 다이어리 데이터를 배열에 저장
            self.diaryEntries = entries
           // self.calendar.reloadData() // 캘린더를 새로고침하여 데이터 표시
            
        }
        
    }
    
    //MARK: -READ2
    func fetchEachDiaries(for date: Date) {
        let userId = Auth.auth().currentUser?.uid ?? ""
           let diariesRef = Database.database().reference().child("users/\(userId)/diaries")
           
           // 날짜를 "yyyy-MM-dd" 형식의 문자열로 변환
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           let dateString = dateFormatter.string(from: date)
           print("**dateString**", dateString)
        
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
                       if let timestamp = self.convertStringToDate(timestampString) {
                           let newEntry = DiaryEntry(title: title, content: content, timestamp: timestamp, diaryId: diaryId)
                           entries.append(newEntry)
                       }
                   }
               }
               
               // 불러온 다이어리 데이터를 배열에 저장
               self.diaryEntries = entries
               //self.tableView.reloadData() // 테이블뷰 새로고침
           }
        
       
    }
    
    // MARK: -CREATE
    // 사용자 경로에 diaries 항목 추가
    func addDiary{
        let userDiaryRef = ref.child("users").child(userId).child("diaries").childByAutoId()
        userDiaryRef.setValue(["title": title, "content":content, "timestamp" :dateString,  "photourl":"url", "diaryId":userDiaryRef.key]) { error, _ in
            if let error = error {
                print("Error saving diary entry: \(error)")
            } else {
                print("Diary entry saved successfully!")
            }
        }
    }
   
    
    
    // MARK: -UPDATE
    func updateDiary{
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
    
    
    
    // MARK: -DELETE
    // Firebase에서 다이어리 삭제하는 메서드
    func deleteDiary(diary: DiaryEntry) {
        let userId = Auth.auth().currentUser?.uid ?? ""
        let diaryRef = Database.database().reference().child("users/\(userId)/diaries")
            
        // diaryId로 해당 항목을 찾아서 삭제
           let query = diaryRef.queryOrdered(byChild: "diaryId").queryEqual(toValue: diary.diaryId) // diaryId를 사용하여 쿼리
           
           query.observeSingleEvent(of: .value) { snapshot in
               if let snapshot = snapshot.children.allObjects.first as? DataSnapshot {
                   // diaryId에 해당하는 항목을 삭제
                   snapshot.ref.removeValue { error, _ in
                       if let error = error {
                           print("Error deleting diary: \(error.localizedDescription)")
                       } else {
                           self.showToast(message: "삭제되었습니다.")
                           // 삭제 후 바로 없어진거 보여주려고
                           self.setEvents()
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
