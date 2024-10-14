//
//  ViewController.swift
//  08_Api_Project
//
//  Created by 이윤주 on 10/13/24.
//

import UIKit
import Toast_Swift

class HomeVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBtn: UIButton!
    
    // MARK: -override method
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeVC - viewDidLoad()")
        self.searchBtn.layer.cornerRadius = 10
        self.searchBar.searchBarStyle = .minimal
        // 모르겟음
        self.searchBar.delegate = self
    }

    // MARK: -filePrivate methods
    // 화면 이동을 함수로 빼기
    fileprivate func pushVC(){
        var segueId:String = ""
        switch searchFilterSegment.selectedSegmentIndex{
        case 0 :
            print("사진 화면으로 이동")
            segueId = "goToPhotoCollectionVC"
        case 1 :
            print("사용자 화면으로 이동")
            segueId = "goToUserListVC"
        default :
            print("default")
            segueId = "goToPhotoCollectionVC"
        }
        // 화면이동, segueId만 넣으면 된다.
        self.performSegue(withIdentifier: segueId, sender: self)
        
    }
    
    // MARK: -IBAction methods
    @IBAction func onSearchBtnClicked(_ sender: UIButton) {
        print("HomeVC - onSearchBtnClicked() called / index : \(searchFilterSegment.selectedSegmentIndex)")
       // 화면으로 이동
        pushVC()
    }
    @IBAction func seachFilterValueChanged(_ sender: UISegmentedControl) {
        print("HomeVC - seachFilterValueChanged() called / index : \(sender.selectedSegmentIndex)")
        
        var searchBarTitle = ""
        switch sender.selectedSegmentIndex{
        case 0:
            searchBarTitle = "사진 키워드"
        case 1:
            searchBarTitle = "사용자 이름"
        default:
            searchBarTitle = "사진 키워드"
        
        }
        
        self.searchBar.placeholder = searchBarTitle + " 입력"
        self.searchBar.becomeFirstResponder() // 포커싱
    }
    
    // MARK: - UISearch BarDelegate Methods
    // 빈 값 검색할 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("HomeVC - searchBarSearchButtonClicked()")
        
        // 언래핑
        guard let userInputString = searchBar.text else {return}
        
        if userInputString.isEmpty {
            self.view.makeToast("📣 검색 키워드를 입력해주세요!",  duration : 2.0 , position:.center)
        }else{
            pushVC()
            searchBar.resignFirstResponder()
        }
    }
    
    
    // 텍스트 입력 감지
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("HomeVC - searchBar / text : \(searchText)")
        if (searchText.isEmpty){
            self.searchBtn.isHidden = true
            // 포커싱 해제
            searchBar.resignFirstResponder()
        }else {
            self.searchBtn.isHidden = false
        }
        
    }
    
    // 텍스트 길이 체크
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 넘어온 text의 길이를 체크
        
        let inputTextCount = searchBar.text?.appending(text).count ?? 0
        
        print("shouldChangeTextIn : \(inputTextCount)")
        if (inputTextCount > 12){
            // 토스트 띄우기
            self.view.makeToast("📣 검색은 최대 12자까지 가능합니다!",  duration : 2.0 , position:.top)
        }
        
//        if (inputTextCount <= 12 ){
//            return true
//        }else{
//            return false
//        }
       // 위 주석도 되고 이렇게 return 도 됨.
       return inputTextCount <= 12
    }
    
}

