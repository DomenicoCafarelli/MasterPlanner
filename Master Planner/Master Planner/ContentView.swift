//
//  ContentView.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 17/01/23.
//

import SwiftUI
import UserNotifications

struct Task: Identifiable {
    let id = UUID()
    let name: String
    let deadline: Date
    var isCompleted: Bool = false
}

struct ContentView: View {
    
    @State private var tasks = [Task]()
       @State private var showAddTask = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
    
    func deleteTask(at offsets: IndexSet) {
            tasks.remove(atOffsets: offsets)
        }
    
    func moveTask(from source: IndexSet, to destination: Int) {
            tasks.move(fromOffsets: source, toOffset: destination)
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




