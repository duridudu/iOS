//
//  ViewController.swift
//  06_Custom Popup
//
//  Created by 이윤주 on 9/8/24.
//

import UIKit
import WebKit
let notificationName = "btnClickNotification"

class ViewController: UIViewController, PopUpDelegate {
   
    @IBOutlet weak var CreatePopupBtn: UIButton!
    @IBOutlet weak var myWebView: WKWebView!
    
    // 뷰컨트롤러가 메모리에서 해제될 때
    // NotificationCenter는 옵저버 해제도 해줘야 좋다. 
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Notification Center 수신기 등록
        NotificationCenter.default.addObserver(self, selector: #selector(loadWebView), name: NSNotification.Name(rawValue: notificationName), object: nil)
    }

    @objc fileprivate func loadWebView(){
        print("ViewController - loadWebView")
        let myChannelUrl = URL(string: "https://blog.naver.com/acd1026")
        self.myWebView.load(URLRequest(url:myChannelUrl!))
        self.dismiss(animated: true, completion: nil)
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

