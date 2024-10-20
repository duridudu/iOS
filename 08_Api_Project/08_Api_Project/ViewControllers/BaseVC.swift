//
//  BaseVC.swift
//  08_Api_Project
//
//  Created by 이윤주 on 10/19/24.
//

import UIKit

class BaseVC:UIViewController{
    var VcTitle: String = ""{
        // VcTitle이 설정이 된 상태면 didSet이 발동된다.
        didSet{
            print("BaseVC - vcTitle didSet() called / vcTitle : \(VcTitle)")
            self.title = VcTitle  
        }
    }
}
