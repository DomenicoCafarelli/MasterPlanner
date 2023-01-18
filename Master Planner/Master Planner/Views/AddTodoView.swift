//
//  AddTodoView.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 18/01/23.
//

import SwiftUI

// Add TO DO View
struct AddTodoView: View {
    @ObservedObject var todoList: TodoList
    @State private var task = ""
    @State private var deadline = Date()
    @State private var comments = ""

    @State private var showingAlert = false
    
    var body: some View {
        Form {
            TextField("Task name", text: $task)
            DatePicker("Deadline", selection: $deadline, in: Date()...)
            TextField("Comments", text: $comments)
            
            Button("Save task") {
                
                //statement to control if the user insert a name for the task that is mandatory
                if task != ""{
                    
                    //if the user insert the name, continue with the saving function
                    
                    let newTodo = Todo(task: self.task, deadline: self.deadline, comments: self.comments)
                    self.todoList.todos.append(newTodo)
                    self.task = ""
                    self.comments = ""
                    self.deadline = Date()
                   
                }else{
                    //if the user DON'T insert the name, show the error message
                    
                    showingAlert = true
                    
                }
            }.alert("Task Name is mandatory", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
        .navigationBarTitle("Add Todo")
    }
}

//struct AddTodoView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTodoView(todoList: <#TodoList#>)
//    }
//}
