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
        var remainingSeconds2: Int // 다음 열차 종료 시각
       // var endTime : Date
    }

    // Fixed non-changing properties about your activity go here!
    var stationName: String
}

struct SubwayLiveLiveActivity: Widget {
    @State private var remainingTime = 60 // 부모 뷰에서 관리하는 상태
    @State private var remainingTime2 = 60 // 부모 뷰에서 관리하는 상태
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SubwayLiveAttributes.self) { context in
            SubwayLiveView(context: context, remainingTime: $remainingTime, remainingTime2: $remainingTime2)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    VStack {
                        Text("이번 열차")
                            .font(.footnote)
                            .padding(.top, 20)
                            
                        Text("\(context.state.remainingSeconds.timeFormatted)")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.bottom,20)
                            }
                        }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack {
                        Text("다음 열차")
                            .font(.footnote)
                            .padding(.top, 20)
                            
                        Text("\(context.state.remainingSeconds2.timeFormatted)")
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding(.bottom,20)
                        }
                               
                    }
                DynamicIslandExpandedRegion(.center) {
                    VStack{
                        Text("🚇 지각 그만! ")
                                .font(.headline)
                                
                       // HStack {
                        
                        Text("📍 \(context.attributes.stationName)")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.top,5)
                            .padding(.bottom,15)
                            }
                           // .padding(.horizontal)
                       // }
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
    @Binding var remainingTime2: Int
    // 여기에서 private을 제거하거나 internal로 변경
//    init(context: ActivityViewContext<SubwayLiveAttributes>, remainingTime: State<Int>) {
//           self.context = context
//           _remainingTime = remainingTime
//    }
//    
    var body: some View {
        VStack {
            Text("🚇 지각 그만! ")
                .font(.headline)
                .padding(.top,30)
                .padding(.leading, 25)
                .frame(maxWidth: .infinity, alignment: .leading) // 왼쪽 정렬
            
              Text("정차역 : \(context.attributes.stationName)")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top,5)
                .padding(.leading, 25)
                  .padding(.bottom, 15)
                  .frame(maxWidth: .infinity, alignment: .leading) // 왼쪽 정렬

              HStack {
                  VStack {
                      Text("이번 열차")
                          .font(.footnote)
                          .foregroundColor(.gray)
                      Text("\(context.state.remainingSeconds.timeFormatted)")
                          .font(.headline)
                          .foregroundColor(.blue)
                  }
                  Spacer()
                          .frame(width: 130) // 원하는 간격을 설정
                  VStack {
                      Text("다음 열차")
                          .font(.footnote)
                          .foregroundColor(.gray)
                      Text("\(context.state.remainingSeconds2.timeFormatted)")
                          .font(.headline)
                          .foregroundColor(.green)
                  }
              }
              .padding(.horizontal,10)
              .padding(.bottom, 30)
          }
          .padding()
          .background(Color.white.opacity(0.5))
    }
    
}


extension SubwayLiveAttributes {
    fileprivate static var preview: SubwayLiveAttributes {
        SubwayLiveAttributes(stationName: "World")
    }
}

extension SubwayLiveAttributes.ContentState {
    fileprivate static var smiley: SubwayLiveAttributes.ContentState {
        SubwayLiveAttributes.ContentState(emoji: "😀", message: "nothing", remainingSeconds: 89, remainingSeconds2: 190)
     }
     
     fileprivate static var starEyes: SubwayLiveAttributes.ContentState {
         SubwayLiveAttributes.ContentState(emoji: "🤩", message: "nothing", remainingSeconds: 89, remainingSeconds2: 190)
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
