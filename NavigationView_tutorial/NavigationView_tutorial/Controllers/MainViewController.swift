//
//  MainViewController.swift
//  NavigationView_tutorial
//
//  Created by 이윤주 on 8/18/24.
//

import Foundation
import UIKit

class MainViewController:UIViewController{
    // 제목
    var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "메인화면"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = UIColor.white
        return label
    }()
    
    var changeBtn: UIButton = {
        let btn = UIButton(type:.system)
        btn.setTitle("배경색 바꾸기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 5
      //  btn.contentEdgeInsets = UIEdgeInsets(top:5, left:20, bottom:5, right: 20)
        
        return btn
    }()
    
    var isBgOrange:Bool?
    
    // 뷰가 생성되었을 때
    override func viewDidLoad() {
        super.viewDidLoad()
        isBgOrange = true
        
        view.backgroundColor = UIColor.orange
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(changeBtn)
        changeBtn.translatesAutoresizingMaskIntoConstraints = false
        changeBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        changeBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //changeBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        changeBtn.addTarget(self, action: #selector(changeBg), for: .touchUpInside)
        
    }
    
    // 배경색을 바꾼다
    @objc fileprivate func changeBg(){
        
        if isBgOrange == true {
            // 배경색 바꾸기
            view.backgroundColor = UIColor.yellow
            isBgOrange = false
        }
        else{
            view.backgroundColor = UIColor.orange
            isBgOrange = true
        }
        
        print("MainViewController - changeBg() called / isBgOrange : \(isBgOrange)")
    }
}
