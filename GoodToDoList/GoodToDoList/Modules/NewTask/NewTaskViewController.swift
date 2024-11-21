//
//  NewTaskViewController.swift
//  GoodToDoList
//
//  Created by Елена Воронцова on 20.11.2024.
//

import UIKit
import RxSwift

final class NewTaskViewController: UIViewController {
    private lazy var mainView = NewTaskView(delegate: self)
    
    private let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
    }
    
    private func setupNavigation() {
        self.title = "Add task"
        
        let rightButton = UIBarButtonItem(title: "Save",
                                          style: .plain,
                                          target: self,
                                          action: #selector(saveOrder))
        rightButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.backButtonTitle = ""
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.mainView.segmentsView.insertSegment(withTitle: "Hight", at: 0, animated: true)
        self.mainView.segmentsView.insertSegment(withTitle: "Medium", at: 1, animated: true)
        self.mainView.segmentsView.insertSegment(withTitle: "Low", at: 2, animated: true)
        self.mainView.segmentsView.selectedSegmentIndex = 0
    }
    
    @objc private func saveOrder() {
        guard let priority = Priority(rawValue: self.mainView.segmentsView.selectedSegmentIndex),
              let title = self.mainView.taskTextField.text else { return }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewTaskViewController: NewTaskViewDelegate { }
