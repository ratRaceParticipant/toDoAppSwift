//
//  NotificationModel.swift
//  ToDoApp
//
//  Created by Himanshu Karamchandani on 30/08/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    
    
    func requestNotification() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("success")
            }
        }
        
        
    }
    func scheduleNotification(toDoModel: ToDoModel) {
        let content = UNMutableNotificationContent()
        content.title =  "Your \(toDoModel.toDoPriority) priority task is due today"
        content.subtitle = "Your Task: \(toDoModel.toDoText) is due today"
        content.sound = .default
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: toDoModel.toDoDuedate)
        
        // For Testing Purpose:
//        var dateComponents = DateComponents()
//        dateComponents.hour = 19
//        dateComponents.minute = 55
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
