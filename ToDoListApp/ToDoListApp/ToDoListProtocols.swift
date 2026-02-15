//
//  ToDoListProtocols.swift
//  ToDoListApp
//
//  Created by Максим Богдан on 15.02.26.
//

import Foundation
import UIKit

// MARK: - View
protocol ToDoListViewProtocol: AnyObject {
    var presenter: ToDoListPresenterProtocol? { get set }
    
    func showTasks(_ tasks: [ToDoModel])
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}

// MARK: - Presenter
protocol ToDoListPresenterProtocol: AnyObject {
    var view: ToDoListViewProtocol? { get set }
    var interactor: ToDoListInteractorProtocol? { get set }
    var router: ToDoListRouterProtocol? { get set }
    
    func viewDidLoad()
    func addTaskTapped()
    func editTaskTapped(task: ToDoModel)
    func deleteTask(task: ToDoModel)
    func searchTasks(query: String)
    func resetSearch()
}

// MARK: - Interactor
protocol ToDoListInteractorProtocol: AnyObject {
    var presenter: ToDoListInteractorOutputProtocol? { get set }
    
    func fetchTasks()
    func deleteTask(_ task: ToDoModel)
    func searchTasks(with query: String)
}

protocol ToDoListInteractorOutputProtocol: AnyObject {
    func tasksFetched(_ tasks: [ToDoModel])
    func tasksFetchFailed(_ error: Error)
    func taskDeleted()
}

// MARK: - Router
protocol ToDoListRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToAddTask(from view: ToDoListViewProtocol)
    func navigateToEditTask(from view: ToDoListViewProtocol, task: ToDoModel)
}
