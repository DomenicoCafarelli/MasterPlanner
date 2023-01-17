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
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
