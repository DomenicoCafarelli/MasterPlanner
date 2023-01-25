//
//  ToDoTaskController.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 25/01/23.
//

import Foundation
import CoreData

class ToDoTaskController: ObservableObject {
    
    // MARK: - Properties
    
    private let entityName = "ToDoTask"
    static var shared = ToDoTaskController()
    
    // MARK: - Initializer
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MasterPlanner")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - CRUD Operations
    
    func createTask(id: UUID, taskName: String, taskDeadline: Date, taskComment: String) -> ToDoTask? {
        let newTask = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? ToDoTask
        newTask?.id = id
        newTask?.taskName = taskName
        newTask?.taskDeadline = taskDeadline
        newTask?.taskComment = taskComment
        save()
        return newTask
    }
    
    func fetchTask() -> [ToDoTask]? {
        let fetchRequest = NSFetchRequest<ToDoTask>(entityName: entityName)
        return try? context.fetch(fetchRequest)
    }
    
        func updateTask(user: ToDoTask, newTaskName: String, newTaskDeadline: Date, newTaskComment: String) {
            user.taskName = newTaskName
            user.taskDeadline = newTaskDeadline
            user.taskComment = newTaskComment
            save()
        }
    
        func deleteUser(user: ToDoTask) {
            context.delete(user)
            save()
        }
    
    
    // MARK: - Helper Methods

    private func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
