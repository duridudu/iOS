//
//  MainViewController.swift
//  oneone2
//
//  Created by 이윤주 on 11/7/24.
//

import UIKit
import FSCalendar
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLogout: UIImageView!
    
    var calendar: FSCalendar!
    var eventsArray = [Date]()
    var todoList: [String] = []
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        showToast(message: "환영합니다! 😸")
        // 오늘 날짜를 가져옴
        let today = Date()
        setEachEvent(for:today)
        
        for fontFamily in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                print(fontName)
            }
        }
        //setupUI()
        for family in UIFont.familyNames {
            print("Font Family: \(family)")
            for fontName in UIFont.fontNames(forFamilyName: family) {
                print("Font Name: \(fontName)")
            }
        }

        
        tableView.dataSource = self
        tableView.delegate = self
        
        // 로그아웃버튼 터치
        // ImageView에 제스처 인식기 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        btnLogout.isUserInteractionEnabled = true
        btnLogout.addGestureRecognizer(tapGesture)
        //
        //        // 테이블 뷰 셀 등록
        //tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
        //
        calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        
        // 필요시 레이아웃 설정 추가
        calendar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendar)
        
        // 제약 조건 설정 (예시)
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendar.heightAnchor.constraint(equalToConstant: 360)
        ])
        
        configureCalendarAppearance()
        setEvents()
    }
    
    // 로그아웃 버튼 클릭
    @objc func imageTapped() {
          // 이미지 뷰가 클릭되었을 때 수행할 동작
          print("ImageView was tapped!")
        showToast(message:"로그아웃 되었습니다.👋")
          // 원하는 동작 추가 (예: 화면 전환, 알림 표시 등)
        // 로그아웃 시
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        UIApplication.shared.windows.first?.rootViewController = loginVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
       
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setEvents()
    }
    // MARK: - TableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    // 섹션별 행 수
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return diaryEntries.count
//    }
//        
//    // 셀 설정
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
//        let diary = diaryEntries[indexPath.row]
//            cell.configure(with: diary)
//            return cell
//    }
    
    
    private func configureCalendarAppearance() {
        
        // 캘린더의 로케일 설정 (한국어로 설정)
        calendar.locale = Locale(identifier: "ko_KR")
        
        //MARK: -상단 헤더 뷰 관련
        calendar.headerHeight = 66 // YYYY년 M월 표시부 영역 높이
        calendar.weekdayHeight = 41 // 날짜 표시부 행의 높이
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0 //헤더 좌,우측 흐릿한 글씨 삭제
        calendar.appearance.headerDateFormat = "YYYY년 M월" //날짜(헤더) 표시 형식
        calendar.appearance.headerTitleColor = .mainColor //2021년 1월(헤더) 색
        calendar.appearance.headerTitleFont = UIFont(name: "NoonnuBasicGothicRegular", size: 22) //타이틀 폰트 크기
        
        
        //MARK: -캘린더(날짜 부분) 관련
        calendar.backgroundColor = .white // 배경색
        calendar.appearance.weekdayTextColor = .black //요일(월,화,수..) 글씨 색
        calendar.appearance.selectionColor = .calendarSelectCircleGrey //선택 된 날의 동그라미 색
        calendar.appearance.titleWeekendColor = .blue //주말 날짜 색
        calendar.appearance.titleDefaultColor = .mainColor //기본 날짜 색
        calendar.appearance.weekdayFont = UIFont(name: "NoonnuBasicGothicRegular", size: 16)
        
        
        //MARK: -오늘 날짜(Today) 관련
        calendar.appearance.titleTodayColor = .white //Today에 표시되는 특정 글자색
        calendar.appearance.todayColor = .mainColor //Today에 표시되는 선택 전 동그라미 색
        calendar.appearance.todaySelectionColor = .mainColor  //Today에 표시되는 선택 후 동그라미 색
        
        // Month 폰트 설정
        calendar.appearance.headerTitleFont = UIFont(name: "NoonnuBasicGothicRegular", size: 16)
        
        
        // day 폰트 설정
        calendar.appearance.titleFont = UIFont(name: "눈누 기초고딕 Regular", size: 14)
        
        
        // border
        calendar.layer.borderColor = UIColor.mainColor.cgColor // 테두리 색상
        calendar.layer.borderWidth = 2.0                   // 테두리 두께
        calendar.layer.cornerRadius = 20.0                 // 둥글기 (조절 가능)
        calendar.layer.masksToBounds = true                // 둥글기 적용
       
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
   
    
    
}
