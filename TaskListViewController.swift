//
//  TaskListViewController.swift
//  FEROMEET
//
//  Created by Максим Богдан on 12.02.26.
//

//import Foundation
//import UIKit
//import SwiftUI
//
//protocol TaskListViewProtocol: AnyObject {
//    func showTasks(_ tasks: [Task])
//    func showError(_ message: String)
//    func showLoading()
//    func hideLoading()
//}
//
//class TaskListViewController: UIViewController, TaskListViewProtocol {
//    var presenter: TaskListPresenterProtocol?
//    
//    private var tasks: [Task] = []
//    private let searchController = UISearchController(searchResultsController: nil)
//    
//    private lazy var tableView: UITableView = {
//        let tv = UITableView()
//        tv.register(UITableViewCell.self, forCellReuseIdentifier: "TaskCell")
//        tv.dataSource = self
//        tv.delegate = self
//        return tv
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupSearch()
//        presenter?.viewDidLoad()
//    }
//    
//    private func setupUI() {
//        title = "Задачи"
//        view.backgroundColor = .systemBackground
//        view.addSubview(tableView)
//        tableView.frame = view.bounds
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .add,
//            target: self,
//            action: #selector(addButtonTapped)
//        )
//    }
//    
//    private func setupSearch() {
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Поиск задач"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//    }
//    
//    @objc private func addButtonTapped() {
//        presenter?.addTaskTapped()
//    }
//    
//    // MARK: - ViewProtocol
//    func showTasks(_ tasks: [Task]) {
//        self.tasks = tasks
//        tableView.reloadData()
//    }
//    
//    func showError(_ message: String) {
//        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
//    }
//    
//    func showLoading() {
//        // Показать индикатор загрузки
//    }
//    
//    func hideLoading() {
//        // Скрыть индикатор
//    }
//}
//
//// MARK: - UITableView DataSource & Delegate
//extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tasks.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
//        let task = tasks[indexPath.row]
//        
//        var config = cell.defaultContentConfiguration()
//        config.text = task.title
//        config.secondaryText = task.isCompleted ? "✅ Выполнена" : "🕐 В процессе"
//        cell.contentConfiguration = config
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let task = tasks[indexPath.row]
//        presenter?.editTaskTapped(task: task)
//    }
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, completion in
//            guard let task = self?.tasks[indexPath.row] else { return }
//            self?.presenter?.deleteTask(task: task)
//            completion(true)
//        }
//        
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
//}
//
//// MARK: - Search
//extension TaskListViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let query = searchController.searchBar.text, !query.isEmpty else {
//            presenter?.resetSearch()
//            return
//        }
//        presenter?.searchTasks(query: query)
//    }
//}
