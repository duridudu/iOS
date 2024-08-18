//
//  ViewController.swift
//  Practice
//
//  Created by 이윤주 on 8/15/24.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    // 제목
    var titleLabel:UILabel = {
        let label = UILabel()
       label.text = "헬로우월두두"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    
    let animationView:LottieAnimationView = {
        let animView = LottieAnimationView(name : "Animation - 1723709822949")
        animView.frame = CGRect(x:0,y:0, width:400, height: 800)
        animView.contentMode = .scaleAspectFill
        return animView
    }()
    
    // 뷰가 생성되었을 때
    override func viewDidLoad() {
        super.viewDidLoad()
        // 애니메이션뷰
        view.addSubview(animationView)
        animationView.center = view.center
        
       
       
        // 애니메이션 실행
        animationView.play{ (finish) in
            print("애니메이션끗")
            self.animationView.removeFromSuperview()
            // Do any additional setup after loading the view.
            self.view.backgroundColor = .white
            self.view.addSubview(self.titleLabel)
            
            // constraint
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.titleLabel.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
            self.titleLabel.centerYAnchor.constraint(equalTo:self.view.centerYAnchor).isActive = true
        }
    }


}

