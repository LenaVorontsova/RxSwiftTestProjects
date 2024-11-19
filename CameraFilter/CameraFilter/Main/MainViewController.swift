//
//  ViewController.swift
//  CameraFilter
//
//  Created by Елена Воронцова on 08.11.2024.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    private lazy var mainView = MainView(delegate: self)
    
    let disposeBag = DisposeBag()
    
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
        
        vc.selectedPhoto.subscribe(onNext: { [weak self] photo in
            self?.mainView.setImage(photo)
        }, onError: { error in
            print("Error selecting photo: \(error)")
        }).disposed(by: disposeBag)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: MainDelegate {
    func applyFilter() {
        
    }
}
