//
//  NewTaskView.swift
//  GoodToDoList
//
//  Created by Елена Воронцова on 20.11.2024.
//

import UIKit

protocol NewTaskViewDelegate: AnyObject { }

final class NewTaskView: UIView {
    public lazy var segmentsView: UISegmentedControl = {
        let view = UISegmentedControl()
        
        view.selectedSegmentIndex = 0
        view.layer.cornerRadius = 5.0
        view.backgroundColor = .brown
        view.tintColor = .white
        view.contentMode = .scaleToFill
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    public lazy var taskTextField: UITextField = {
        let view = UITextField()
        view.layer.borderColor = UIColor.brown.cgColor
        view.layer.borderWidth = 0.5
        view.textColor = .black
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: NewTaskViewDelegate?
    
    init(delegate: NewTaskViewDelegate?) {
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
        self.addSubview(taskTextField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            segmentsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            segmentsView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            taskTextField.topAnchor.constraint(equalTo: segmentsView.bottomAnchor, constant: 30),
            taskTextField.widthAnchor.constraint(equalToConstant: 200),
            taskTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
}
