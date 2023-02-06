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
    @State private var taskName = ""
    // State variable to hold the deadline date
    @State private var taskDeadline = Date()
    // State variable to hold the comments
    @State private var taskComment = ""
    
    // State variable to control the display of the alert
    @State private var showingAlert = false
    
    @Binding var showingAddToDo: Bool

    
    var body: some View {
        Form {
            // Text field for the task name
            TextField("Task name", text: $taskName)
            // Date picker for the deadline
            DatePicker("Deadline", selection: $taskDeadline, in: Date()...)
            // Text field for the comments
            TextField("Comments", text: $taskComment)
            
            // Save button
            Button("Save task") {
                
                // Check if the task name is not empty
                if taskName != ""{
                    
                    ToDoTaskController.shared.createTask(id: UUID(), taskName: taskName, taskDeadline: taskDeadline, taskComment: taskComment)!
                    showingAddToDo.toggle()
                    
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
