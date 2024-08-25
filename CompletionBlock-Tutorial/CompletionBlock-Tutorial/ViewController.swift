//
//  ViewController.swift
//  CompletionBlock-Tutorial
//
//  Created by 이윤주 on 8/25/24.
//

import UIKit
import KRProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var MainTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ViewController - viewDidLoad() called")
        
        // 프로그레스바 보이기
        KRProgressHUD.show()
        sayHi(completion: { result in
            print("컴플레션 블락으로 넘겨 받았음. : \(result)")
            // 프로그레스바 끝난거 보이기
            KRProgressHUD.showSuccess()
            self.MainTitle.text = result
        })
    }
    
    fileprivate func sayHi(completion:@escaping(String) -> ()){
        print("ViewController - sayHi() called")
        // 메인스레드에서 딜레이 주기
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Put your code which should be executed with a delay here
            print("하이")
            
            completion("컴플레션블락 끗.")
        }
    }

}

