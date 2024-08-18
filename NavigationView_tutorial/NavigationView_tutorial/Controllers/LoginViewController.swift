//
//  ViewController.swift
//  NavigationView_tutorial
//
//  Created by 이윤주 on 8/17/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    // 뷰가 실행되었을 때
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 상단 네비게이션바 숨김처리
        self.navigationController?.isNavigationBarHidden = true
        
        loginBtn.addTarget(self, action: #selector(moveToMainViewController), for: .touchUpInside)
    }
    
    // 메인화면으로 이동
   @objc fileprivate func moveToMainViewController(){
        print("LoginViewController - MoveToMainViewController")
       let mainViewController = MainViewController()
       self.navigationController?.pushViewController(mainViewController, animated: true)
    }


}

