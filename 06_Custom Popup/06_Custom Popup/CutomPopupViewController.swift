//
//  CutomPopupViewController.swift
//  06_Custom Popup
//
//  Created by 이윤주 on 9/8/24.
//

import UIKit

class CutomPopupViewController:UIViewController {
  
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var openChatBtn: UIButton!
    
    var subscribeBtnCompletionClosure:(() -> Void)?
    var myPopUpDelegate : PopUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CustomPopupViewController called")
        // 모서리 설정
        contentView.layer.cornerRadius = 30
        subscribeBtn.layer.cornerRadius = 10
        openChatBtn.layer.cornerRadius = 10
    }
    
    @IBAction func onBgBtnClicked(_ sender: UIButton) {
        print("CutomPopupViewController - onBgBtnClicked() called")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onSubscribeBtnClicked(_ sender: UIButton) {
        print("CutomPopupViewController - onSubscribeBtnClicked() called")
        self.dismiss(animated: true, completion: nil)
        //컴플레션 블럭 호출
        if let subscribeBtnCompletionClosure = subscribeBtnCompletionClosure{
            // 메인에 알린다.
            subscribeBtnCompletionClosure()
 
        }
    }
    @IBAction func onOpenChatBtnClicked(_ sender: UIButton) {
        print("CutomPopupViewController - onOpenChatBtnClicked() called")
        myPopUpDelegate?.onOpenChatBtnClicked()
    }
    
}
