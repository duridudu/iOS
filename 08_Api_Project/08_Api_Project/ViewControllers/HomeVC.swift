//
//  ViewController.swift
//  08_Api_Project
//
//  Created by 이윤주 on 10/13/24.
//

import UIKit
import Toast_Swift

class HomeVC: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBtn: UIButton!
    var keyboardDismissTabGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: HomeVC.self, action: nil)
    // MARK: -override method
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeVC - viewDidLoad()")
        self.config()
    }
 
    // 네비게이션 스택에서 다른 화면으로 넘어가기 전에 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HomeVc prepare called() / segue.identifier : \(segue.identifier)")
        switch segue.identifier{
        case SEGUE_ID.USER_LIST_VC :
            // 다음 화면의 뷰컨트롤러를 가져온다.
            let nextVC = segue.destination as! UserListVC
            guard let userInputValue = self.searchBar.text else {return}
            nextVC.VcTitle = userInputValue + "🤹"
        case SEGUE_ID.PHOTO_COLLECTION_VC :
            let nextVC = segue.destination as! PhotoCollectionVC
            guard let photoInputValue = self.searchBar.text else {return}
            nextVC.VcTitle = photoInputValue + "🎆"
        default:
            print("default")
        
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("HomeVC - viewDidAppear() called")
        // 포커싱
        //self.searchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC - viewWillAppear() called")
        // 노티를 등록한다.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideHandle(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillAppear - viewWillDisappear called")
        // 노티 해지한다.
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: -filePrivate methods
    fileprivate func config() {
        // ui 설정
        self.searchBtn.layer.cornerRadius = 10
        self.searchBar.searchBarStyle = .minimal
        
        // delegate 설정
        // 모르겟음
        self.searchBar.delegate = self
        // 키보드 밖 터치 레코그나이저 선택
        self.keyboardDismissTabGesture.delegate = self
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
        
        // 포커싱
        self.searchBar.becomeFirstResponder()
    }
    
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
    
    // 키보드 올라갔다 내려갔다 인식
    @objc func keyboardWillShowHandle(notification:NSNotification){
        print("keyboardWillShowHandle() called")
        // 키보드가 검색 버튼 덮는지 확인
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            print("keyboardSize.height : \(keyboardSize.height)")
            print("searchBtn.y : \(searchBtn.frame.origin.y)")
            // 키보드가 덮으면
            if (keyboardSize.height < searchBtn.frame.origin.y){
                let distance = keyboardSize.height  - searchBtn.frame.origin.y
                print("이만틈 덮음 : \(distance)")
                self.view.frame.origin.y = distance - (searchBtn.frame.height)
            }
        }
    }
    
    @objc func keyboardWillHideHandle(notification:NSNotification){
        print("keyboardWillHideHandle()")
    }
     
    // MARK: -IBAction methods
    @IBAction func onSearchBtnClicked(_ sender: UIButton) {
        print("HomeVC - onSearchBtnClicked() called / index : \(searchFilterSegment.selectedSegmentIndex)")
       // 화면으로 이동
        pushVC()
    }
    
    @IBAction func seachFilterValueChanged(_ sender: UISegmentedControl) {
        // print("HomeVC - seachFilterValueChanged() called / index : \(sender.selectedSegmentIndex)")
        
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
            // x로 지울 때 살짝 딜레이줘서 포커싱 해제한다.
            DispatchQueue.main.asyncAfter(deadline: .now()+0.01, execute: {
                // 포커싱 해제
                searchBar.resignFirstResponder()
            })
            
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
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // print("HomeVC - gestureRecognizer() called")
        // 터치로 들어온 애가 뷰세그먼트나 서치바이면
        if (touch.view?.isDescendant(of: searchFilterSegment)==true){
            print("세그먼트 터치됨")
            return false
        }
        else if (touch.view?.isDescendant(of: searchBar) == true){
            print("터치바 터치됨")
            return false
        }
        else{
            // 키보드 내리기
            view.endEditing(true)
            return true
        }
        
        
    }
    
}

