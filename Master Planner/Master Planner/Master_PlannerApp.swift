//
//  Master_PlannerApp.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 17/01/23.
//

import SwiftUI

@main
struct Master_PlannerApp: App {
    
    @StateObject var toDoTaskController = ToDoTaskController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView(todoList: TodoList.init()).environmentObject(toDoTaskController)
        }
    }
}
