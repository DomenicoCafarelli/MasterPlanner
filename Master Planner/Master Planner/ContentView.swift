//
//  ContentView.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 17/01/23.
//

import SwiftUI

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
}


struct ContentView: View {
    
    @EnvironmentObject var todoList: TodoList
    
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
                    // add new todo
                }) {
                    Image(systemName: "plus")
                }
            )
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
    static var previews: some View {
        ContentView()
    }
}
