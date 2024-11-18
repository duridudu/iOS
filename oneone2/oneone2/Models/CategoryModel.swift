//
//  CategoryModel.swift
//  oneone2
//
//  Created by 이윤주 on 11/18/24.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class CategoryModel{
    private var userId: String?
    private var categoriesRef:DatabaseReference?
    var categoriesEntries = [CategoryEntry]()

    static let shared = CategoryModel() // 싱글턴 인스턴스
    private init() {} // 외부에서 인스턴스를 생성하지 못하도록 설정

    // userId를 설정하는 메서드
    func setUserId(_ id: String) {
        self.userId = id
        self.categoriesRef = Database.database().reference().child("users/\(String(describing: userId))/categories")
    }

    func addCategory(category: CategoryEntry){
        let userCategoryRef = categoriesRef?.childByAutoId()
        userCategoryRef?.setValue(["categoryName": category.categoryName, "categoryEmoji":category.categoryEmoji] ) { error, _ in
            if let error = error {
                print("Error saving diary entry: \(error)")
            } else {
                print("Diary entry saved successfully!")
            }
        }
    }
                                 
    func fetchCategories(completion: @escaping ([CategoryEntry]) -> Void){
            
        print("---SET CATEGORIES---")
        if let categoriesRef = categoriesRef {
            categoriesRef.observe(.value) { snapshot in
            // snapshot 처리
            var entries = [CategoryEntry]()
            entries.append(CategoryEntry(categoryName: "전체", categoryEmoji: "🔎"))
                
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let categoryData = snapshot.value as? [String: Any] {
                            
                        let categoryName = categoryData["categoryName"] as? String ?? ""
                        let categoryEmoji = categoryData["categoryEmoji"] as? String ?? ""
                    
                        // "전체" 항목이 중복되지 않도록 추가
//                        if !entries.contains(where: { $0.categoryName == categoryName }) {
//                            entries.append(Category(categoryName: categoryName, categoryEmoji: categoryEmoji))
//                                       }
                        let newEntry = CategoryEntry(categoryName: categoryName, categoryEmoji: categoryEmoji)
                        if !entries.contains(where: { $0.categoryName == categoryName }){
                            entries.append(newEntry)
                        }
                      
                        }
                    }
                
                    // 불러온 다이어리 데이터를 배열에 저장
                    self.categoriesEntries = entries
                    print("카테고리 끝, 개수는? ", entries.count)
                    completion(self.categoriesEntries) // 데이터를 콜백으로 전달
                }
            } else {
                print("Error: diariesRef is nil")
            }
    }
}
