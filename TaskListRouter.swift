//
//  TaskListRouter.swift
//  FEROMEET
//
//  Created by Максим Богдан on 12.02.26.
//

//import Foundation
//import UIKit
//
//protocol TaskListRouterProtocol: AnyObject {
//    static func createModule() -> UIViewController
//    func navigateToAddTask(from view: TaskListViewProtocol)
//    func navigateToEditTask(from view: TaskListViewProtocol, task: Task)
//}
//
//class TaskListRouter: TaskListRouterProtocol {
//    weak var viewController: UIViewController?
//    
//    static func createModule() -> UIViewController {
//        let view = TaskListViewController()
//        let interactor = TaskListInteractor()
//        let presenter = TaskListPresenter()
//        let router = TaskListRouter()
//        
//        view.presenter = presenter
//        presenter.view = view
//        presenter.interactor = interactor
//        presenter.router = router
//        interactor.presenter = presenter
//        router.viewController = view
//        
//        return view
//    }
//    
//    func navigateToAddTask(from view: TaskListViewProtocol) {
//        let addTaskVC = TaskDetailRouter.createModule(task: nil)
//        (view as? UIViewController)?.navigationController?.pushViewController(addTaskVC, animated: true)
//    }
//    
//    func navigateToEditTask(from view: TaskListViewProtocol, task: Task) {
//        let editTaskVC = TaskDetailRouter.createModule(task: task)
//        (view as? UIViewController)?.navigationController?.pushViewController(editTaskVC, animated: true)
//    }
//}
