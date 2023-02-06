//
//  ContentView.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 17/01/23.
//

import SwiftUI

struct ContentView: View {
    
    // The observed object for the todo list
    @ObservedObject var todoList: TodoList
    
    // The state variable for showing the add todo view
    @State var tasks: [ToDoTask] = []
    @State var showingAddTodo = false
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                List {
                    
                    // For each todo, create a navigation link to the todo detail view
                    ForEach(tasks) { todo in
                        
                        VStack(alignment: .leading) {
                            
                            Text(todo.taskName ?? "Not found")
                                .font(.headline)
                        }
                    }
                    
                    // Add the ability to delete todos
                    .onDelete { indexSet in
                        self.todoList.todos.remove(atOffsets: indexSet)
                        ToDoTaskController.shared.deleteTask(user: (ToDoTaskController.shared.fetchTask()?.first)!)
                        tasks = ToDoTaskController.shared.fetchTask()!
                    }
                }
                .navigationBarTitle("Todo List")
                // Add a button to the navigation bar to open the add todo view
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.showingAddTodo.toggle()
                }) {
                    Image(systemName: "plus")
                }
                )
                // Show the add todo view as a sheet when the button is tapped
                .sheet(isPresented: $showingAddTodo,onDismiss: {
                    tasks = ToDoTaskController.shared.fetchTask()!
                }) {
                    AddTodoView(todoList: self.todoList, showingAddToDo: $showingAddTodo)
                }
            }.onAppear {
                tasks = ToDoTaskController.shared.fetchTask()!
            }
        }
    }
    
    // formatter to display the deadline date
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct ContentView_Previews: PreviewProvider {
    // The observed object for the todo list
    @ObservedObject var todoList: TodoList
    
    static var previews: some View {
        ContentView(todoList: TodoList.init())
    }
}


func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Request authorization for the application to send notifications
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
        // If an error occurs while requesting authorization, print the error message to the console
        if let error = error {
            print("Error requesting notification authorization: \(error)")
        }
    }
    // Return true to indicate that the launch process was successful
    return true
}
