//
//  TaskListViewController.swift
//  GoodToDoList
//
//  Created by Елена Воронцова on 20.11.2024.
//

import UIKit
import RxSwift
import RxRelay

final class TaskListViewController: UIViewController {
    
    private lazy var mainView = TaskListView(delegate: self)
    
    private let disposeBag = DisposeBag()
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    override func loadView() {
        super.loadView()

        self.view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
        setupViews()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.mainView.segmentsView.insertSegment(withTitle: "All", at: 0, animated: true)
        self.mainView.segmentsView.insertSegment(withTitle: "Hight", at: 1, animated: true)
        self.mainView.segmentsView.insertSegment(withTitle: "Medium", at: 2, animated: true)
        self.mainView.segmentsView.insertSegment(withTitle: "Low", at: 3, animated: true)
        self.mainView.segmentsView.selectedSegmentIndex = 0
    }
    
    private func setupNavigation() {
        self.title = "GoodList"
        
        let rightButton = UIBarButtonItem(image: UIImage.add,
                                          style: .plain,
                                          target: self,
                                          action: #selector(addNewTask))
        rightButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightButton
    }

    private func setupViews() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
    
    @objc private func addNewTask() {
        let vc = NewTaskViewController()
        
        vc.taskSubjectObservable
            .subscribe(onNext: { [unowned self] task in
                let priority = Priority(rawValue: self.mainView.segmentsView.selectedSegmentIndex - 1)
                
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)
                
                self.filterTask(by: priority)
            })
            .disposed(by: disposeBag)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func filterTask(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = tasks.value
            self.updateTableView()
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority! }
            }.subscribe(onNext: { [ weak self ] tasks in
                self?.filteredTasks = tasks
                self?.updateTableView()
            }).disposed(by: disposeBag)
        }
    }
}

extension TaskListViewController: TaskListViewDelegate {
    func priorityValueChanged(segment: UISegmentedControl) {
        let priority = Priority(rawValue: self.mainView.segmentsView.selectedSegmentIndex - 1)
        filterTask(by: priority)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .black
        
        let task = filteredTasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }
}
