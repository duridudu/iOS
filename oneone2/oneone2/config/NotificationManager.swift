//
//  NotificationManager.swift
//  oneone2
//
//  Created by 이윤주 on 11/24/24.
//

import Foundation

import UserNotifications

class NotificationManager{
    func requestPermission() {
           UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
               if granted {
                   print("Permission granted!")
               } else {
                   print("Permission denied.")
               }
           }
       }
    
    // MARK: -CREATE
    func scheduleNotification(for diary: DiaryEntry, on date: Date, diaryId:String) {
        let content = UNMutableNotificationContent()
        content.title = "일일이 : 작성한 일정을 알려드려요!🔎"
        content.body = diary.title
        content.sound = .default

        // 날짜 구성 요소 설정
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        dateComponents.hour = 0 // 자정에 알림 설정
        dateComponents.minute = 0
        dateComponents.second = 0

        // 알림 트리거 생성
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        // 1초 뒤 알림을 울리도록 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // 알림 요청 생성 (다이어리 ID를 identifier로 사용)
        let request = UNNotificationRequest(identifier: diaryId, content: content, trigger: trigger)
        print("Notification Request created with identifier: \(diaryId)")
        print("Diary 상태 : \(diary.title)")
        // 알림 등록
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for diary \(diaryId)")
            }
        }
    }

    // MARK: -REMOVE
    func removeNotification(for diaryID: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [diaryID])
    }

    // MARK: -UPDATE
    func updateNotification(for diary: DiaryEntry, with newDate: Date) {
        removeNotification(for: diary.diaryId) // 기존 알림 제거
        scheduleNotification(for: diary, on: newDate, diaryId: diary.diaryId) // 새 알림 등록
    }

    
}
