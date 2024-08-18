//
//  ViewController.swift
//  QrCode_tutorial
//
//  Created by 이윤주 on 8/18/24.
//

import UIKit
import WebKit

class MainViewController: UIViewController {

    @IBOutlet weak var qrcodeBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string : "https://www.naver.com")
        let requestObj = URLRequest(url : url!)
        webView.load(requestObj)
        
        qrcodeBtn.layer.borderWidth = 3
        qrcodeBtn.layer.borderColor = UIColor.blue.cgColor
        qrcodeBtn.layer.cornerRadius = 10 
        qrcodeBtn.addTarget(self, action: #selector(qrcodeReaderLaunch), for: .touchUpInside)
    }

    @objc fileprivate func qrcodeReaderLaunch(){
        print("mainViewController - qrCodeReaderLaunch")
    }

}

