//
//  MainViewController+FSCalendar.swift
//  oneone2
//
//  Created by 이윤주 on 11/9/24.
//

import UIKit
import FSCalendar

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // 이벤트 밑에 Dot 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        // 원하는 날짜를 생성
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print("DOT self.diaryEntries.count : ", diaryEntries.count)
        for entry in diaryEntries {
           let tempDate = formatter.date(from: entry.timestamp)!
           if isSameDay(tempDate, date) {
                return 1
            }
        }
        return 0
    }
    
    // 날짜가 동일한지 비교하는 함수
        func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
            let calendar = Calendar.current
            return calendar.isDate(date1, inSameDayAs: date2)
        }
    
    // 날짜가 선택되었을 때 호출되는 메서드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // 날짜가 선택될 때마다 해당 날짜에 맞는 데이터를 불러옴
        setEachEvent(for: date)
    }
    
    
}
