//
//  ViewController.swift
//  05_NavigationBar_NO_StroyBoard
//
//  Created by 이윤주 on 9/7/24.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "홈"
        
        self.view.backgroundColor = .yellow
        
        // 네비게이션 아이템 추가
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(goToProfileVC))
        
        // 네비게이션 아이템 추가
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "message.fill"), style: .plain, target: self, action: #selector(goToMessageVC))
    }
    
    @objc fileprivate func goToProfileVC(){
        print("MainViewController : goToProfileVC() called")
        let profileVC = ProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }

    @objc fileprivate func goToMessageVC(){
        print("MainViewController : goToMessageVC() called")
        let messageVC = MessageViewController()
        self.navigationController?.pushViewController(messageVC, animated: true)
    }
}

