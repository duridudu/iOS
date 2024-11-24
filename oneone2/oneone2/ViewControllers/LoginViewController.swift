//
//  LoginViewController.swift
//  oneone2
//
//  Created by 이윤주 on 11/7/24.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController:UIViewController {
    
    
    @IBOutlet weak var editPw: UITextField!
    @IBOutlet weak var editId: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editPw.isSecureTextEntry = true
        let NotificationManager = NotificationManager()
        NotificationManager.requestPermission()
        // 이미 로그인한 경우 메인 화면으로 이동
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            moveToMainScreen()
        }
        
        // Tap gesture recognizer 설정
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        btnLogin.layer.cornerRadius = 15
    }
    
//    // 푸시 권한
//    func requestNotificationPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//            if granted {
//                print("Notification permission granted!")
//            } else {
//                print("Notification permission denied: \(error?.localizedDescription ?? "No error")")
//            }
//        }
//    }
//    
    // 회원가입 함수
      func signUp(email: String, password: String) {
          Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              if let error = error {
                  print("Error signing up: \(error.localizedDescription)")
                  return
              }
              // 회원가입 성공 시 메인 화면으로 이동
              print("User signed up successfully: \(authResult?.user.email ?? "")")
              self.saveLoginStateAndMoveToMain()
          }
      }

      // 로그인 함수
      func signIn(email: String, password: String) {
          Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
              if let error = error {
                  print("Login error: \(error.localizedDescription)")
                  // 로그인 실패 시 회원가입 시도
                  self.signUp(email: email, password: password)
                  return
              }
              
              // 로그인 성공 시 메인 화면으로 이동
              print("User logged in successfully: \(authResult?.user.email ?? "")")
              self.saveLoginStateAndMoveToMain()
          }
      }
      
    func saveLoginStateAndMoveToMain() {
            UserDefaults.standard.set(true, forKey: "isLoggedIn") // 로그인 상태 저장
            moveToMainScreen()
        }
    
    func moveToMainScreen() {
        showToast(message: "환영합니다! 😻")
        // 로그인 후 userId 설정
        UserSession.shared.userId = Auth.auth().currentUser?.uid ?? ""
        DiaryModel.shared.setUserId(Auth.auth().currentUser?.uid ?? "")
        CategoryModel.shared.setUserId(Auth.auth().currentUser?.uid ?? "")
        
        print("USER INFO : ", Auth.auth().currentUser?.uid ?? "")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        
        // SceneDelegate의 window를 통해 rootViewController 설정
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = mainVC
            sceneDelegate.window?.makeKeyAndVisible()
        }
        
        
    }


    
    @IBAction func btnJoinClicked(_ sender: UIButton) {
        view.endEditing(true) // 키보드 내리기
        guard let email = editId.text, !email.isEmpty,
                      let password = editPw.text, !password.isEmpty else {
                    print("Please enter both email and password.")
                    return
                }
                // 로그인 시도 (로그인 실패 시 자동으로 회원가입 시도)
                signIn(email: email, password: password)
    }

    
    @objc func dismissKeyboard() {
        view.endEditing(true) // 키보드 내리기
    }
    
    func showToast(message: String, duration: Double = 2.0) {
           // 토스트 메시지의 라벨 생성
           let toastLabel = UILabel()
           toastLabel.text = message
           toastLabel.font = UIFont.systemFont(ofSize: 14)
           toastLabel.textColor = .white
           toastLabel.textAlignment = .center
           toastLabel.numberOfLines = 0
           
           // 라벨 배경과 스타일 설정
           toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
           toastLabel.layer.cornerRadius = 10
           toastLabel.clipsToBounds = true
           
           // 라벨 위치와 크기 설정
           let textSize = toastLabel.intrinsicContentSize
           let labelWidth = min(textSize.width + 40, view.frame.width - 40)
           let labelHeight = textSize.height + 20
           toastLabel.frame = CGRect(x: (view.frame.width - labelWidth) / 2,
                                     y: view.frame.height - 100,
                                     width: labelWidth,
                                     height: labelHeight)
           
           // 토스트 메시지를 뷰에 추가하고 애니메이션으로 나타나게 하기
           view.addSubview(toastLabel)
           UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
               toastLabel.alpha = 0.0
           }) { _ in
               toastLabel.removeFromSuperview() // 애니메이션 종료 후 제거
           }
       }
}

