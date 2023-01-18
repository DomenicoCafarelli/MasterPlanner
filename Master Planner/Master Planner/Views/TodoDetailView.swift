//
//  TodoDetailView.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 18/01/23.
//

import SwiftUI

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

//struct TodoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoDetailView(todo: )
//    }
//}



