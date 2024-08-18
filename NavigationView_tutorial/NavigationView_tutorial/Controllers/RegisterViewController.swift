//
//  RegisterViewController.swift
//  NavigationView_tutorial
//
//  Created by 이윤주 on 8/17/24.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var BtnForLoginControllerView: UIButton!
    
    // 뷰가 실행되었을 때
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 상단 네비게이션바 숨김처리
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func onLoginViewControllerBtnClicked(_ sender: UIButton) {
        print("RegisterViewController - onLoginViewControllerBtnClicked called / 로그인 버튼 클릭!")
        // 네비게이션뷰 컨트롤러 팝하기
        self.navigationController?.popViewController(animated: true)
    }
    
}
