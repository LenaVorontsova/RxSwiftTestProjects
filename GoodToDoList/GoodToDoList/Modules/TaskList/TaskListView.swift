//
//  TaskListView.swift
//  GoodToDoList
//
//  Created by Елена Воронцова on 20.11.2024.
//

import UIKit

protocol TaskListViewDelegate: AnyObject {
    func priorityValueChanged(segment: UISegmentedControl)
}

final class TaskListView: UIView {
    public lazy var segmentsView: UISegmentedControl = {
        let view = UISegmentedControl()
        
        view.selectedSegmentIndex = 0
        view.layer.cornerRadius = 5.0
        view.backgroundColor = .brown
        view.tintColor = .white
        view.contentMode = .scaleToFill
        
        view.addTarget(self, action: #selector(priorityValueChanged), for: .valueChanged)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    public lazy var tableView: UITableView = {
        let view = UITableView()
        view.isScrollEnabled = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: TaskListViewDelegate?
    
    init(delegate: TaskListViewDelegate?) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        self.delegate = delegate
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(segmentsView)
        self.addSubview(tableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            segmentsView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentsView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            segmentsView.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.80),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    @objc func priorityValueChanged(segment: UISegmentedControl) {
        self.delegate?.priorityValueChanged(segment: segment)
    }
}
