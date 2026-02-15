//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by Максим Богдан on 15.02.26.
//

import SwiftUI
import CoreData

@main
struct ToDoListAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
