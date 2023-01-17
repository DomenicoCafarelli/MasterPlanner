//
//  ContentView.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 17/01/23.
//

import SwiftUI
import UserNotifications


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
