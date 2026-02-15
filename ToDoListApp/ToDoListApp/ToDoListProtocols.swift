//
//  ToDoListProtocols.swift
//  ToDoListApp
//
//  Created by Максим Богдан on 15.02.26.
//

import Foundation
import UIKit

// MARK: - View
protocol TaskListViewProtocol: AnyObject {
    var presenter: TaskListPresenterProtocol? { get set }
    
    func showTasks(_ tasks: [ToDoModel])
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}

// MARK: - Presenter
protocol TaskListPresenterProtocol: AnyObject {
    var view: TaskListViewProtocol? { get set }
    var interactor: TaskListInteractorProtocol? { get set }
    var router: TaskListRouterProtocol? { get set }
    
    func viewDidLoad()
    func addTaskTapped()
    func editTaskTapped(task: ToDoModel)
    func deleteTask(task: ToDoModel)
    func searchTasks(query: String)
    func resetSearch()
}

// MARK: - Interactor
protocol TaskListInteractorProtocol: AnyObject {
    var presenter: TaskListInteractorOutputProtocol? { get set }
    
    func fetchTasks()
    func deleteTask(_ task: ToDoModel)
    func searchTasks(with query: String)
}

protocol TaskListInteractorOutputProtocol: AnyObject {
    func tasksFetched(_ tasks: [ToDoModel])
    func tasksFetchFailed(_ error: Error)
    func taskDeleted()
}

// MARK: - Router
protocol TaskListRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToAddTask(from view: TaskListViewProtocol)
    func navigateToEditTask(from view: TaskListViewProtocol, task: ToDoModel)
}
