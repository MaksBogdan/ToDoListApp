//
//  TaskListPresenter.swift
//  FEROMEET
//
//  Created by Максим Богдан on 12.02.26.
//

//import Foundation
//
//protocol TaskListPresenterProtocol: AnyObject {
//    var view: TaskListViewProtocol? { get set }
//    var interactor: TaskListInteractorProtocol? { get set }
//    var router: TaskListRouterProtocol? { get set }
//    
//    func viewDidLoad()
//    func addTaskTapped()
//    func editTaskTapped(task: Task)
//    func deleteTask(task: Task)
//    func searchTasks(query: String)
//    func resetSearch()
//}
//
//class TaskListPresenter: TaskListPresenterProtocol {
//    weak var view: TaskListViewProtocol?
//    var interactor: TaskListInteractorProtocol?
//    var router: TaskListRouterProtocol?
//    
//    private var allTasks: [Task] = []
//    
//    func viewDidLoad() {
//        view?.showLoading()
//        interactor?.fetchTasks()
//    }
//    
//    func addTaskTapped() {
//        router?.navigateToAddTask(from: view!)
//    }
//    
//    func editTaskTapped(task: Task) {
//        router?.navigateToEditTask(from: view!, task: task)
//    }
//    
//    func deleteTask(task: Task) {
//        interactor?.deleteTask(task)
//    }
//    
//    func searchTasks(query: String) {
//        interactor?.searchTasks(with: query)
//    }
//    
//    func resetSearch() {
//        view?.showTasks(allTasks)
//    }
//}
//
//// MARK: - Interactor Output
//extension TaskListPresenter: TaskListInteractorOutputProtocol {
//    func tasksFetched(_ tasks: [Task]) {
//        self.allTasks = tasks
//        DispatchQueue.main.async {
//            self.view?.hideLoading()
//            self.view?.showTasks(tasks)
//        }
//    }
//    
//    func tasksFetchFailed(_ error: Error) {
//        DispatchQueue.main.async {
//            self.view?.hideLoading()
//            self.view?.showError(error.localizedDescription)
//        }
//    }
//    
//    func taskDeleted() {
//        interactor?.fetchTasks() // Обновляем список
//    }
//}
