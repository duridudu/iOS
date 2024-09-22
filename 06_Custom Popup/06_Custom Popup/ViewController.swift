//
//  ViewController.swift
//  06_Custom Popup
//
//  Created by 이윤주 on 9/8/24.
//

import UIKit
import WebKit

class ViewController: UIViewController, PopUpDelegate {
   
    @IBOutlet weak var CreatePopupBtn: UIButton!
    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onCreatePopupBtn(_ sender: UIButton) {
        print("ViewController - onCreatePopupBtn called")
        
        // 스토리보드 가져오기
        let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
        // 스토리보드 통해 뷰 컨트롤러 가져오기
        let customPopUpVC = storyboard.instantiateViewController(withIdentifier: "AlertPopUpVC") as! CutomPopupViewController
        
        // 팝업효과 설정 (나타나는 스타일)
        customPopUpVC.modalPresentationStyle = .overCurrentContext
        // 뷰 컨트롤러가 사라지는 스타일
        customPopUpVC.modalTransitionStyle = .crossDissolve
        
        customPopUpVC.subscribeBtnCompletionClosure = {
            print("컴플레션 블럭 호출됨")
            let myChannelUrl = URL(string: "https://velog.io/@duridudu/posts")
            self.myWebView.load(URLRequest(url:myChannelUrl!))
        }
        self.present(customPopUpVC, animated: true, completion: nil)
        customPopUpVC.myPopUpDelegate = self
    }
    
    func onOpenChatBtnClicked() {
        print("ViewController - onOpenChatBtnClicked called")
        let myChannelUrl = URL(string: "https://github.com/duridudu")
        self.myWebView.load(URLRequest(url:myChannelUrl!))
        self.dismiss(animated: true, completion: nil)
    }
    
}

