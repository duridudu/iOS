//
//  ViewController.swift
//  04_02TabbarController_NoStoryboard
//
//  Created by 이윤주 on 9/1/24.
//

import UIKit

class MyViewController: UIViewController {
    convenience init(title:String, bgColor:UIColor){
        self.init()
        
        self.title = title
        self.view.backgroundColor = bgColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    
}

