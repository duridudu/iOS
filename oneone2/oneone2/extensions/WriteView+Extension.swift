//
//  WriteView+Extension.swift
//  oneone2
//
//  Created by 이윤주 on 11/18/24.
//

import Foundation
import FloatingPanel

extension WriteViewController {
    
    var position: FloatingPanelPosition {
        return .bottom
    }

    var initialState: FloatingPanelState {
        return .half // 원하는 초기 상태 설정
    }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelAdaptiveLayoutAnchor(absoluteOffset: .init(x: 0, y: 200), referenceGuide: .safeArea),
            .tip: FloatingPanelAdaptiveLayoutAnchor(absoluteOffset: .init(x: 0, y: 100), referenceGuide: .safeArea),
        ]
    }
}
