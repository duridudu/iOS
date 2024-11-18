//
//  CategoryAddViewController.swift
//  oneone2
//
//  Created by 이윤주 on 11/18/24.
//

import Foundation
import UIKit

class CategoryAddViewController:UIViewController, UITextFieldDelegate {
    
    var emoji:String?
    var name:String?
    var category:CategoryEntry?
    var categoryViewModel = CategoryViewModel()
    
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editEmoji: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // 바탕색
        editEmoji.delegate = self
        editName.delegate = self
        
    }
    
   
    
    @IBAction func btnOk(_ sender: UIButton) {
        emoji = editEmoji.text
        name = editName.text
        
        categoryViewModel.newCategory( category: CategoryEntry(categoryName: name ?? "", categoryEmoji: emoji ?? ""))
        
        // 화면 닫기
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
  
    
}
