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
    
    // Function to schedule a notification for a given Todo
    func scheduleNotification(for todo: Todo) {
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = todo.task
        content.sound = UNNotificationSound.default
        // Create a date component for the deadline of the Todo
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: todo.deadline)
        // Create a trigger with the date component and set it to not repeat
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        // Create a request with the trigger and the notification content
        let request = UNNotificationRequest(identifier: todo.id.uuidString, content: content, trigger: trigger)
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
}
