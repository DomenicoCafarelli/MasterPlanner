//
//  TodoViewModel.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 18/01/23.
//

import Foundation
import UserNotifications

// State to hold the Todo data
class TodoList: ObservableObject {
    @Published var todos: [Todo] = []
    
    func scheduleNotification(for todo: Todo) {
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = todo.task
        content.sound = UNNotificationSound.default
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: todo.deadline)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: todo.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
}
