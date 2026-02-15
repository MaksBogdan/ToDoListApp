//
//  CoreDataStack.swift
//  FEROMEET
//
//  Created by Максим Богдан on 12.02.26.
//

//import Foundation
//import CoreData
//
//class CoreDataStack {
//    static let shared = CoreDataStack()
//    
//    // Для UI (View Context) - main queue
//    lazy var viewContext: NSManagedObjectContext = {
//        persistentContainer.viewContext
//    }()
//    
//    // Для фоновых операций (save, delete, fetch) - private queue
//    func newBackgroundContext() -> NSManagedObjectContext {
//        let context = persistentContainer.newBackgroundContext()
//        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//        return context
//    }
//    
//    private lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "ToDoListModel")
//        container.loadPersistentStores { _, error in
//            if let error = error {
//                fatalError("Core Data store failed: \(error.localizedDescription)")
//            }
//        }
//        container.viewContext.automaticallyMergesChangesFromParent = true
//        return container
//    }()
//}
