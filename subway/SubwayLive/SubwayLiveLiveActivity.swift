//
//  SubwayLiveLiveActivity.swift
//  SubwayLive
//
//  Created by 이윤주 on 12/13/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SubwayLiveAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
        var message: String
        var remainingSeconds: Int // 종료 시각
        var endTime : Date
    }

    // Fixed non-changing properties about your activity go here!
    var stationName: String
}

struct SubwayLiveLiveActivity: Widget {
    @State private var remainingTime = 1133 // 부모 뷰에서 관리하는 상태
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SubwayLiveAttributes.self) { context in
            SubwayLiveView(context: context, remainingTime: $remainingTime)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                            Text("🚇")
                        }
                        DynamicIslandExpandedRegion(.trailing) {
                            Text("\(remainingTime.timeFormatted)")
                        }
                        DynamicIslandExpandedRegion(.bottom) {
                            Text("\(context.attributes.stationName)")
                        }
            } compactLeading: {
                Text("🚇")
            } compactTrailing: {
                Text("⏱️")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
struct SubwayLiveView: View {
    let context: ActivityViewContext<SubwayLiveAttributes>
    @Binding var remainingTime: Int // 부모에서 전달받은 Binding

    // 여기에서 private을 제거하거나 internal로 변경
//    init(context: ActivityViewContext<SubwayLiveAttributes>, remainingTime: State<Int>) {
//           self.context = context
//           _remainingTime = remainingTime
//    }
//    
    var body: some View {
            VStack(spacing: 10) {
                Text("🚇 \(context.attributes.stationName)")
                    .font(.headline)
                Text("\(context.state.emoji) \(context.state.message)")
                    .font(.subheadline)
                Text("남은 시간: \(context.state.remainingSeconds.timeFormatted)")
                    .font(.title)
                    .foregroundColor(.red)
            }
            .padding()
            .onAppear {
                    startTimer() // 타이머 시작
        }
    }
    
   
    private func startTimer() {
        print("SubwayLiveView야=============++===")
           remainingTime = 119 // 초기 값 설정
           Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
               if remainingTime > 0 {
                   remainingTime -= 1 // 1초씩 감소
               } else {
                   timer.invalidate() // 타이머 멈추기
                  // refreshAPI() // 타이머가 0초 되면 새 데이터로 갱신
               }
           }
       }

}


extension SubwayLiveAttributes {
    fileprivate static var preview: SubwayLiveAttributes {
        SubwayLiveAttributes(stationName: "World")
    }
}

extension SubwayLiveAttributes.ContentState {
    fileprivate static var smiley: SubwayLiveAttributes.ContentState {
        SubwayLiveAttributes.ContentState(emoji: "😀", message: "nothing", remainingSeconds: 89, endTime: Date().addingTimeInterval(89))
     }
     
     fileprivate static var starEyes: SubwayLiveAttributes.ContentState {
         SubwayLiveAttributes.ContentState(emoji: "🤩", message: "nothing", remainingSeconds: 89, endTime: Date().addingTimeInterval(89))
     }
}

extension Int {
    var timeFormatted: String {
        let minutes = self / 60
        let seconds = self % 60
        return "\(minutes)분 \(seconds)초"
    }
}



#Preview("Notification", as: .content, using: SubwayLiveAttributes.preview) {
   SubwayLiveLiveActivity()
} contentStates: {
    SubwayLiveAttributes.ContentState.smiley
    SubwayLiveAttributes.ContentState.starEyes
}
