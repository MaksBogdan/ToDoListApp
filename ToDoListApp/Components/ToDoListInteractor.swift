//
//  ToDoListInteractor.swift
//  ToDoListApp
//
//  Created by Максим Богдан on 15.02.26.
//

import Foundation
import CoreData

class ToDoListInteractor: ToDoListInteractorProtocol {
    
    weak var presenter: ToDoListInteractorOutputProtocol?
    
    private let coreDataStack = CoreDataStack.shared
    private let networkService = NetworkService()
    
    private var isFirstLaunch: Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            return true
        }
        return false
    }
    
    func fetchTasks() {
        let context = coreDataStack.newBackgroundContext()
        
        context.perform { [weak self] in
            guard let self = self else { return }
            
            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            
            do {
                let count = try context.count(for: fetchRequest)
                
                if count == 0 && self.isFirstLaunch {
                    // Первый запуск - загружаем с API
                    self.loadFromAPI(context: context)
                } else {
                    // Загружаем из CoreData
                    self.loadFromCoreData(context: context)
                }
            } catch {
                DispatchQueue.main.async {
                    self.presenter?.tasksFetchFailed(error)
                }
            }
        }
    }
    
    private func loadFromAPI(context: NSManagedObjectContext) {
        Task {
            do {
                let todos = try await networkService.fetchTodos()
                
                await context.perform {
                    for todo in todos {
                        let taskEntity = TaskEntity(context: context)
                        taskEntity.id = Int64(todo.id)
                        taskEntity.title = todo.todo
                        taskEntity.desc = "Задача из dummyjson"
                        taskEntity.createdAt = Date()
                        taskEntity.isCompleted = todo.completed
                        taskEntity.userId = Int64(todo.userId)
                    }
                    
                    do {
                        try context.save()
                        self.loadFromCoreData(context: context)
                    } catch {
                        DispatchQueue.main.async {
                            self.presenter?.tasksFetchFailed(error)
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.presenter?.tasksFetchFailed(error)
                }
            }
        }
    }
    
    private func loadFromCoreData(context: NSManagedObjectContext) {
        context.perform {
            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            
            do {
                let taskEntities = try context.fetch(fetchRequest)
                let tasks = taskEntities.map { ToDoModel(from: $0) }
                
                DispatchQueue.main.async {
                    self.presenter?.tasksFetched(tasks)
                }
            } catch {
                DispatchQueue.main.async {
                    self.presenter?.tasksFetchFailed(error)
                }
            }
        }
    }
    
    func deleteTask(_ task: ToDoModel) {
        let context = coreDataStack.newBackgroundContext()
        
        context.perform {
            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %lld", task.id)
            
            do {
                let results = try context.fetch(fetchRequest)
                results.forEach { context.delete($0) }
                try context.save()
                
                DispatchQueue.main.async {
                    self.presenter?.taskDeleted()
                }
            } catch {
                DispatchQueue.main.async {
                    self.presenter?.tasksFetchFailed(error)
                }
            }
        }
    }
    
    func searchTasks(with query: String) {
        let context = coreDataStack.newBackgroundContext()
        
        context.perform {
            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(
                format: "title CONTAINS[cd] %@ OR desc CONTAINS[cd] %@",
                query, query
            )
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
            
            do {
                let taskEntities = try context.fetch(fetchRequest)
                let tasks = taskEntities.map { ToDoModel(from: $0) }
                
                DispatchQueue.main.async {
                    self.presenter?.tasksFetched(tasks)
                }
            } catch {
                DispatchQueue.main.async {
                    self.presenter?.tasksFetchFailed(error)
                }
            }
        }
    }
}
