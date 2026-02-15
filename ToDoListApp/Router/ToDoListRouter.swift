//
//  ToDoListRouter.swift
//  ToDoListApp
//
//  Created by Максим Богдан on 15.02.26.
//

import Foundation
import UIKit

class ToDoListRouter: ToDoListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        
        let view = ToDoListViewController()
        let interactor = ToDoListInteractor()
        let presenter = ToDoListPresenter()
        let router = ToDoListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToAddTask(from view: ToDoListViewProtocol) {
        let alert = UIAlertController(
            title: "Добавить задачу",
            message: "Функция будет реализована позже",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        if let sourceView = view as? UIViewController {
            sourceView.present(alert, animated: true)
        }
    }
    
    func navigateToEditTask(from view: ToDoListViewProtocol, task: ToDoModel) {
        let alert = UIAlertController(
            title: "Редактировать",
            message: "Задача: \(task.title)\nФункция будет реализована позже",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        if let sourceView = view as? UIViewController {
            sourceView.present(alert, animated: true)
        }
    }
}
