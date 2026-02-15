//
//  TaskListInteractor.swift
//  FEROMEET
//
//  Created by Максим Богдан on 12.02.26.
//

//import Foundation
//
//protocol TaskListInteractorProtocol: AnyObject {
//    var presenter: TaskListInteractorOutputProtocol? { get set }
//    func fetchTasks()
//    func deleteTask(_ task: Task)
//    func searchTasks(with query: String)
//}
//
//protocol TaskListInteractorOutputProtocol: AnyObject {
//    func tasksFetched(_ tasks: [Task])
//    func tasksFetchFailed(_ error: Error)
//    func taskDeleted()
//}
//
//class TaskListInteractor: TaskListInteractorProtocol {
//    weak var presenter: TaskListInteractorOutputProtocol?
//    private let coreDataStack = CoreDataStack.shared
//    private let networkService = NetworkService()
//    
//    // MARK: - Загрузка с API (только при первом запуске)
//    func fetchTasks() {
//        let context = coreDataStack.newBackgroundContext()
//        
//        context.perform { [weak self] in
//            guard let self = self else { return }
//            
//            // Проверяем, есть ли данные в CoreData
//            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
//            
//            do {
//                let count = try context.count(for: fetchRequest)
//                
//                if count == 0 {
//                    // Нет данных - загружаем с API
//                    self.loadFromAPI(context: context)
//                } else {
//                    // Есть данные - загружаем из CoreData
//                    self.loadFromCoreData(context: context)
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    self.presenter?.tasksFetchFailed(error)
//                }
//            }
//        }
//    }
//    
//    private func loadFromAPI(context: NSManagedObjectContext) {
//        networkService.fetchTodos { [weak self] result in
//            guard let self = self else { return }
//            
//            switch result {
//            case .success(let todos):
//                context.perform {
//                    // Сохраняем в CoreData
//                    for todo in todos {
//                        let taskEntity = TaskEntity(context: context)
//                        taskEntity.id = Int64(todo.id)
//                        taskEntity.title = todo.todo
//                        taskEntity.desc = "Задача из dummyjson" // API не дает описания
//                        taskEntity.createdAt = Date()
//                        taskEntity.isCompleted = todo.completed
//                        taskEntity.userId = Int64(todo.userId)
//                    }
//                    
//                    do {
//                        try context.save()
//                        // После сохранения загружаем данные из CoreData
//                        self.loadFromCoreData(context: context)
//                    } catch {
//                        DispatchQueue.main.async {
//                            self.presenter?.tasksFetchFailed(error)
//                        }
//                    }
//                }
//                
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.presenter?.tasksFetchFailed(error)
//                }
//            }
//        }
//    }
//    
//    private func loadFromCoreData(context: NSManagedObjectContext) {
//        context.perform {
//            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
//            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
//            
//            do {
//                let taskEntities = try context.fetch(fetchRequest)
//                let tasks = taskEntities.map { entity -> Task in
//                    Task(
//                        id: Int(entity.id),
//                        title: entity.title,
//                        description: entity.desc,
//                        createdAt: entity.createdAt,
//                        isCompleted: entity.isCompleted,
//                        userId: Int(entity.userId)
//                    )
//                }
//                
//                DispatchQueue.main.async {
//                    self.presenter?.tasksFetched(tasks)
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    self.presenter?.tasksFetchFailed(error)
//                }
//            }
//        }
//    }
//    
//    func deleteTask(_ task: Task) {
//        let context = coreDataStack.newBackgroundContext()
//        
//        context.perform {
//            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
//            fetchRequest.predicate = NSPredicate(format: "id == %d", task.id)
//            
//            do {
//                let results = try context.fetch(fetchRequest)
//                results.forEach { context.delete($0) }
//                try context.save()
//                
//                DispatchQueue.main.async {
//                    self.presenter?.taskDeleted()
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    self.presenter?.tasksFetchFailed(error)
//                }
//            }
//        }
//    }
//    
//    func searchTasks(with query: String) {
//        let context = coreDataStack.newBackgroundContext()
//        
//        context.perform {
//            let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
//            fetchRequest.predicate = NSPredicate(
//                format: "title CONTAINS[cd] %@ OR desc CONTAINS[cd] %@",
//                query, query
//            )
//            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
//            
//            do {
//                let taskEntities = try context.fetch(fetchRequest)
//                let tasks = taskEntities.map { entity -> Task in
//                    Task(
//                        id: Int(entity.id),
//                        title: entity.title,
//                        description: entity.desc,
//                        createdAt: entity.createdAt,
//                        isCompleted: entity.isCompleted,
//                        userId: Int(entity.userId)
//                    )
//                }
//                
//                DispatchQueue.main.async {
//                    self.presenter?.tasksFetched(tasks)
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    self.presenter?.tasksFetchFailed(error)
//                }
//            }
//        }
//    }
//}
