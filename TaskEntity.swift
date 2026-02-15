//
//  TaskEntity.swift
//  FEROMEET
//
//  Created by Максим Богдан on 12.02.26.
//


//import Foundation
//import CoreData
//
//extension TaskEntity {
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
//        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
//    }
//    @NSManaged public var id: Int64
//    @NSManaged public var title: String
//    @NSManaged public var desc: String?
//    @NSManaged public var createdAt: Date
//    @NSManaged public var isCompleted: Bool
//    @NSManaged public var userId: Int64
//}
//
//
//extension TaskEntity : Identifiable {
//    // Добавляем computed property для безопасной работы с опционалами
//    var safeTitle: String {
//        title ?? "Без названия"
//    }
//    
//    var safeDescription: String {
//        desc ?? "Нет описания"
//    }
//    
//    var safeCreatedAt: Date {
//        createdAt ?? Date()
//    }
//}
