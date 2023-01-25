//
//  ToDoTask+CoreDataProperties.swift
//  Master Planner
//
//  Created by Domenico Cafarelli on 25/01/23.
//
//

import Foundation
import CoreData


extension ToDoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoTask> {
        return NSFetchRequest<ToDoTask>(entityName: "ToDoTask")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var taskDeadline: Date?
    @NSManaged public var taskComment: String?
    @NSManaged public var id: UUID?

}

extension ToDoTask : Identifiable {

}
