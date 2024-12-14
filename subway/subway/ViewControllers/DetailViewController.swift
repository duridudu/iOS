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
        startLiveActivity(station: "영등포시장역", first: 94, second: 198)
    }

   
    func startLiveActivity(station: String, first:Int, second:Int) {
        let attributes = SubwayLiveAttributes(stationName: station)
            let initialState = SubwayLiveAttributes.ContentState(
                emoji: "🚇",
                message: "Train Arriving",
                remainingSeconds: first,
                remainingSeconds2 : second
              //  endTime: Date().addingTimeInterval(89)
            )

            do {
                let activity = try Activity<SubwayLiveAttributes>.request(
                    attributes: attributes,
                    contentState: initialState,
                    pushType: nil
                )
                print("Live Activity started: \(activity.id)")

                // Start Timer
                startTimerForLiveActivity(first: first, second: second)
            } catch {
                print("Failed to start Live Activity: \(error)")
            }
       }
    
    
    func updateLiveActivity( first:Int, second:Int) {
        Task {
            let updatedState = SubwayLiveAttributes.ContentState(
                emoji: "🚇",
                message: "Train Arriving",
                remainingSeconds: first,
                remainingSeconds2 : second
            )

            // 현재 활성화된 모든 Live Activity 업데이트
            for activity in Activity<SubwayLiveAttributes>.activities {
                await activity.update(using: updatedState)
            }
        }
    }
    
    func startTimerForLiveActivity(first:Int, second:Int) {
        var remainingSeconds = first // API에서 받아온 초기 남은 시간
        var remainingSeconds2 = second // API에서 받아온 초기 남은 시간
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
                remainingSeconds2 -= 1
                self.updateLiveActivity(first: remainingSeconds, second: remainingSeconds2)
            } else {
                timer.invalidate()
                // API를 다시 호출하거나 Activity를 종료
               // endLiveActivity()
            }
        }
        
      
    }
    
}
