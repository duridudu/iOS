//
//  CustomFloatingPanelLayout.swift
//  oneone2
//
//  Created by 이윤주 on 11/18/24.
//

import Foundation
import FloatingPanel

class CustomFloatingPanelLayout: FloatingPanelLayout {
    // 탭 바의 높이를 저장할 변수
    private let tabBarHeight: CGFloat
    // 초기화 메서드에서 탭 바의 높이를 받습니다.
        init(tabBarHeight: CGFloat) {
            self.tabBarHeight = tabBarHeight
        }
    
    var position: FloatingPanelPosition {
        return .bottom
    }

    var initialState: FloatingPanelState {
        return .half // 원하는 초기 상태 설정
    }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 30.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 450.0, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 1.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}
