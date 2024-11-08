//
//  ViewController.swift
//  CameraFilter
//
//  Created by Елена Воронцова on 08.11.2024.
//

import UIKit

class MainViewController: UIViewController {
    private lazy var mainView = MainView(delegate: self)
    
    override func loadView() {
        super.loadView()
        
        self.view = self.mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupUI()
    }

    private func setupNavigationController() {
        title = "Filter photo"
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(selectImage))
        rightButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
    }
    
    // Handles user actions related to interacting with the UI
    
    @objc private func selectImage() {
        let vc = PhotosViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: MainDelegate {
    func applyFilter() {
        
    }
}
