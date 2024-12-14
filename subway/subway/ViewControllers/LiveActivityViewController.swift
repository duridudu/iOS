//
//  LiveActivityViewController.swift
//  subway
//
//  Created by 이윤주 on 12/13/24.
//

import UIKit
import ActivityKit

class LiveActivityViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 버튼을 눌러 Live Activity를 시작하도록 구성
        let startButton = UIButton(type: .system)
        startButton.setTitle("Start Live Activity", for: .normal)
        startButton.addTarget(self, action: #selector(startLiveActivity), for: .touchUpInside)
        startButton.center = view.center
        view.addSubview(startButton)
    }
    
    @objc func startLiveActivity() {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities are not enabled.")
            return
        }
        
        let attributes = SubwayLiveAttributes(stationName: "영등포시장")
        let initialState = SubwayLiveAttributes.ContentState(emoji: "🚊", message: "Train Arriving Soon")
        
        do {
            let activity = try Activity<SubwayLiveAttributes>.request(
                attributes: attributes,
                contentState: initialState,
                pushType: nil // PushType: nil은 로컬 상태만 관리
            )
            print("Live Activity started: \(activity.id)")
        } catch {
            print("Failed to start Live Activity: \(error)")
        }
    }
}
