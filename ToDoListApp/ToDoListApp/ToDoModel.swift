//
//  ToDoModel.swift
//  ToDoListApp
//
//  Created by Максим Богдан on 15.02.26.
//

import Foundation

struct ToDoModel {
    let id: Int64
    var title: String
    var description: String?
    var createdAt: Date
    var isCompleted: Bool
    var userId: Int64
    
    init(from entity: TaskEntity) {
        self.id = entity.id
        self.title = entity.title ?? ""
        self.description = entity.desc
        self.createdAt = entity.createdAt ?? Date()
        self.isCompleted = entity.isCompleted
        self.userId = entity.userId
    }
    
    init(id: Int64, title: String, description: String?, createdAt: Date, isCompleted: Bool, userId: Int64) {
        self.id = id
        self.title = title
        self.description = description
        self.createdAt = createdAt
        self.isCompleted = isCompleted
        self.userId = userId
    }
    
    static func createNew() -> ToDoModel {
        let newId = Int64(Date().timeIntervalSince1970 * 1000)
        return ToDoModel(
            id: newId,
            title: "",
            description: nil,
            createdAt: Date(),
            isCompleted: false,
            userId: 0
        )
    }
}
