//
//  ToDoListPresenter.swift
//  ToDoListApp
//
//  Created by Максим Богдан on 15.02.26.
//

import Foundation


class ToDoListPresenter: ToDoListPresenterProtocol {
    
    weak var view: ToDoListViewProtocol?
    var interactor: ToDoListInteractorProtocol?
    var router: ToDoListRouterProtocol?
    
    private var allTasks: [ToDoModel] = []
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.fetchTasks()
    }
    
    func addTaskTapped() {
        router?.navigateToAddTask(from: view!)
    }
    
    func editTaskTapped(task: ToDoModel) {
        router?.navigateToEditTask(from: view!, task: task)
    }
    
    func deleteTask(task: ToDoModel) {
        interactor?.deleteTask(task)
    }
    
    func searchTasks(query: String) {
        interactor?.searchTasks(with: query)
    }
    
    func resetSearch() {
        view?.showTasks(allTasks)
    }
}

// MARK: - Interactor Output
extension ToDoListPresenter: ToDoListInteractorOutputProtocol {
    
    func tasksFetched(_ tasks: [ToDoModel]) {
        self.allTasks = tasks
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.view?.showTasks(tasks)
        }
    }
    
    func tasksFetchFailed(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.view?.showError(error.localizedDescription)
        }
    }
    
    func taskDeleted() {
        interactor?.fetchTasks() 
    }
}
