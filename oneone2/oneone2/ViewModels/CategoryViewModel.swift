//
//  CategoryViewModel.swift
//  oneone2
//
//  Created by 이윤주 on 11/18/24.
//

import Foundation
class CategoryViewModel{
    // View에서 userId를 받아서 Model에 전달
    func setUserId(_ id: String) {
        CategoryModel.shared.setUserId(id)
    }
    
    // Create
    func newCategory(category:CategoryEntry){
        CategoryModel.shared.addCategory(category: category)
    }
    
    // READ all
    func setAllCategories(completion: @escaping ([CategoryEntry]) -> Void){
        CategoryModel.shared.fetchCategories{ categories in 
            completion(categories)
        }
    }
}
