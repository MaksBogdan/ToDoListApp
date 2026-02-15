//
//  TaskEntity+CoreDataProperties.swift
//  ToDoListApp
//
//  Created by Максим Богдан on 15.02.26.
//
//

public import Foundation
public import CoreData


public typealias TaskEntityCoreDataPropertiesSet = NSSet

extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var desc: String?
    @NSManaged public var id: Int64
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?
    @NSManaged public var userId: Int64

}

extension TaskEntity : Identifiable {

}
