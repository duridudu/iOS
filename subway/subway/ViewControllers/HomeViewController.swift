//
//  HomeViewController.swift
//  subway
//
//  Created by 이윤주 on 12/8/24.
//

import Foundation
import UIKit
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet weak var BtnDest: UIButton!
    @IBOutlet weak var BtnLine: UIButton!
    @IBOutlet weak var BtnSearch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for familyName in UIFont.familyNames {
                print("Family: \(familyName)")
                for fontName in UIFont.fontNames(forFamilyName: familyName) {
                    print("   Font: \(fontName)")
                }
            }
        
        self.BtnDest.titleLabel?.font = UIFont(name:"Mungyeong-Gamhong-Apple.ttf", size:19)
        self.BtnLine.titleLabel?.font = UIFont(name:"Mungyeong-Gamhong-Apple", size:19)
        self.BtnSearch.titleLabel?.font = UIFont(name:"Mungyeong-Gamhong-Apple", size:19)
    }
    

    @IBAction func btnOkClicked(_ sender: UIButton) {
        
//        guard let userInput = self.searchBar.text else {return}
        let userInput = "영등포시장"
        var urlToCall:URLRequestConvertible?
        urlToCall = MyRouter.searchArrival(term: userInput)
//        switch searchFilterSegment.selectedSegmentIndex{
//        case 0:
//            urlToCall = MySearchRouter.searchPhotos(term: userInput)
//        case 1:
//            urlToCall = MySearchRouter.searchUsers(term: userInput)
//        default:
//            print("default")
//        }
//        
        if let urlConvertible = urlToCall{
            MyAlamofireManager
                .shared
                .session
                .request(urlConvertible)
                .validate(statusCode: 200..<401) // validate 안하면 에러일 때 retry 호출이 안됨, 200에서 401 아래까지만 허용
                .responseJSON(completionHandler: { response in
                    debugPrint(response)
                })
            //pushVC()
        }
    }
    
    // 네비게이션 스택에서 다른 화면으로 넘어가기 전에 준비
    // 역이름, 남은 초, 남은 초2
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HomeVc prepare called() / segue.identifier : \(segue.identifier)")
        switch segue.identifier{
        case SEGUE_ID.LIST_VC :
            // 다음 화면의 뷰컨트롤러를 가져온다.
            let nextVC = segue.destination as! ListViewController
//            guard let userInputValue = self.searchBar.text else {return}
//            nextVC.VcTitle = userInputValue + "🤹"
        case SEGUE_ID.DETAIL_VC :
            let nextVC = segue.destination as! DetailViewController
            // api 호출
            let userInput = "영등포시장"
            var urlToCall:URLRequestConvertible?
            urlToCall = MyRouter.searchArrival(term: userInput)
            if let urlConvertible = urlToCall{
                MyAlamofireManager
                    .shared
                    .session
                    .request(urlConvertible)
                    .validate(statusCode: 200..<401) // validate 안하면 에러일 때 retry 호출이 안됨, 200에서 401 아래까지만 허용
                    .responseJSON(completionHandler: { response in
                        switch response.result {
                                    case .success(let value):
                                        // JSON 데이터를 디코딩하거나 가공
                                        guard let jsonDict = value as? [String: Any] else { return }
                                                
                                        // 다음 화면에 전달할 데이터 설정
                                        nextVC.arrivalData = jsonDict // 다음 화면에 데이터 전달
                                                
                                    case .failure(let error):
                                        print("Error: \(error)")
                                    }
                                })
                //pushVC()
            }
//            guard let photoInputValue = self.searchBar.text else {return}
//            nextVC.VcTitle = photoInputValue + "🎆"
        default:
            print("default")
        
        }
    }

    
    // 화면 이동을 함수로 빼기
    fileprivate func pushVC(){
        var segueId:String = ""
//        switch searchFilterSegment.selectedSegmentIndex{
//        case 0 :
//            print("사진 화면으로 이동")
//            segueId = "goToPhotoCollectionVC"
//        case 1 :
//            print("사용자 화면으로 이동")
//            segueId = "goToUserListVC"
//        default :
//            print("default")
//            segueId = "goToPhotoCollectionVC"
//        }
        segueId = "goToDetail"
        // 화면이동, segueId만 넣으면 된다.
        self.performSegue(withIdentifier: segueId, sender: self)
        
    }
    
    
}
