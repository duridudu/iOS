//
//  DetailViewController.swift
//  subway
//
//  Created by 이윤주 on 12/8/24.
//

import Foundation
import UIKit
import ActivityKit

class DetailViewController: UIViewController {

    var arrivalData: [String: Any]? // JSON 데이터를 받을 변수

    override func viewDidLoad() {
        super.viewDidLoad()
//        if let data = arrivalData {
//            print("*******Received Data: \(data)")
//        }
        print("DETAIL VIEW")
        startLiveActivity()
    }

   
    func startLiveActivity() {
        let attributes = SubwayLiveAttributes(stationName: "영등포시장역")
            let initialState = SubwayLiveAttributes.ContentState(
                emoji: "🚇",
                message: "Train Arriving",
                remainingSeconds: 89,
                endTime: Date().addingTimeInterval(89)
            )

            do {
                let activity = try Activity<SubwayLiveAttributes>.request(
                    attributes: attributes,
                    contentState: initialState,
                    pushType: nil
                )
                print("Live Activity started: \(activity.id)")

                // Start Timer
                startTimerForLiveActivity()
            } catch {
                print("Failed to start Live Activity: \(error)")
            }
       }
    
    
    func updateLiveActivity(remainingSeconds: Int) {
        Task {
            let updatedState = SubwayLiveAttributes.ContentState(
                emoji: "⏱",
                message: "Train Departing Soon",
                remainingSeconds: remainingSeconds,
                endTime: Date().addingTimeInterval(TimeInterval(remainingSeconds))
            )

            // 현재 활성화된 모든 Live Activity 업데이트
            for activity in Activity<SubwayLiveAttributes>.activities {
                await activity.update(using: updatedState)
            }
        }
    }
    
    func startTimerForLiveActivity() {
        var remainingSeconds = 89 // API에서 받아온 초기 남은 시간

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
                self.updateLiveActivity(remainingSeconds: remainingSeconds)
            } else {
                timer.invalidate()
                // API를 다시 호출하거나 Activity를 종료
               // endLiveActivity()
            }
        }
    }
    
}
