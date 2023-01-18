//
//  TodoModel.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 18/01/23.
//

import Foundation

// Model to hold the Todo data
struct Todo: Identifiable {
    let id = UUID()
    var task: String
    var deadline: Date
    var comments: String
}
