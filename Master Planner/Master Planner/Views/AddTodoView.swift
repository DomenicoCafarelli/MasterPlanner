//
//  AddTodoView.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 18/01/23.
//

import SwiftUI

// Add TO DO View
struct AddTodoView: View {
    // Observed object for the todo list
    @ObservedObject var todoList: TodoList
    // State variable to hold the task name
    @State private var task = ""
    // State variable to hold the deadline date
    @State private var deadline = Date()
    // State variable to hold the comments
    @State private var comments = ""
    
    // State variable to control the display of the alert
    @State private var showingAlert = false

    
    var body: some View {
        Form {
            // Text field for the task name
            TextField("Task name", text: $task)
            // Date picker for the deadline
            DatePicker("Deadline", selection: $deadline, in: Date()...)
            // Text field for the comments
            TextField("Comments", text: $comments)
            
            // Save button
            Button("Save task") {
                
                // Check if the task name is not empty
                if task != ""{
                    
                    // If the task name is not empty, continue with the saving function
                    let newTodo = Todo(task: self.task, deadline: self.deadline, comments: self.comments)
                    self.todoList.todos.append(newTodo)
                    self.task = ""
                    self.comments = ""
                    self.deadline = Date()
                }else{
                    // If the task name is empty, show an alert
                    showingAlert = true
                }
            }.alert("Task Name is mandatory", isPresented: $showingAlert) {
                // OK button for the alert
                Button("OK", role: .cancel) { }
            }
        }
        // Set the navigation bar title
        .navigationBarTitle("Add Todo")
    }
}


//struct AddTodoView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTodoView(todoList: <#TodoList#>)
//    }
//}
