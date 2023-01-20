//
//  TodoModel.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 18/01/23.
//

import Foundation

// Model to hold the Todo data
struct Todo: Identifiable {
    // Unique identifier for the Todo
    let id = UUID()
    // Task name
    var task: String
    // Deadline date
    var deadline: Date
    // Comments
    var comments: String
}

