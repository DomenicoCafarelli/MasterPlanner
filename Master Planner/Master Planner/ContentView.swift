//
//  ContentView.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 17/01/23.
//

import SwiftUI
import UserNotifications


// Model to hold the Todo data
struct Todo: Identifiable {
    let id = UUID()
    var task: String
    var deadline: Date
    var comments: String
}

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

// SwiftUI View to display the details of a Todo
struct TodoDetailView: View {
    var todo: Todo

    var body: some View {
        VStack {
            Text(todo.task)
                .font(.largeTitle)
            Text("Deadline: \(todo.deadline, formatter: ContentView.dateFormatter)")
                .font(.title)
            Divider()
            Text("Comments: \(todo.comments)")
                .font(.body)
        }
        .navigationBarTitle("Todo Details")
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

    var body: some View {
        Form {
            TextField("Task name", text: $task)
            DatePicker("Deadline", selection: $deadline, in: Date()...)
            TextField("Comments", text: $comments)
            
            Button("Save task") {
                
                if task != ""{
                    print("ok")
                    let newTodo = Todo(task: self.task, deadline: self.deadline, comments: self.comments)
                    self.todoList.todos.append(newTodo)
                    self.task = ""
                    self.comments = ""
                    self.deadline = Date()
                   
                }else{
                    print("nonono")
                }
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
