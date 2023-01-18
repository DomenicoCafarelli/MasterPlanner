//
//  ContentView.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 17/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var todoList: TodoList
    @State var showingAddTodo = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(todoList.todos) { todo in
                    NavigationLink(destination: TodoDetailView(todo: todo)) {
                        VStack(alignment: .leading) {
                            Text(todo.task)
                                .font(.headline)
                            Text("Deadline: \(todo.deadline, formatter: Self.dateFormatter)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete { indexSet in
                    self.todoList.todos.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Todo List")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddTodo.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddTodo) {
                AddTodoView(todoList: self.todoList)
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

//
struct ContentView_Previews: PreviewProvider {
    
    @ObservedObject var todoList: TodoList
    
    static var previews: some View {
        ContentView(todoList: TodoList.init())
    }
}


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


func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
        if let error = error {
            print("Error requesting notification authorization: \(error)")
        }
    }
    return true
}
