//
//  TodoDetailView.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 18/01/23.
//

import SwiftUI

// SwiftUI View to display the details of a Todo
struct TodoDetailView: View {
    
    // The Todo object to be displayed
    var todo: Todo
    
    var body: some View {
        VStack {
            // Display the task name
            Text(todo.task)
                .font(.largeTitle)
            // Display the deadline date
            Text("Deadline: \(todo.deadline, formatter: ContentView.dateFormatter)")
                .font(.title)
            Divider()
            // Display the comments
            Text("Comments: \(todo.comments)")
                .font(.body)
        }
        // Set the navigation bar title
        .navigationBarTitle("Todo Details")
    }
}


//struct TodoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoDetailView(todo: )
//    }
//}



