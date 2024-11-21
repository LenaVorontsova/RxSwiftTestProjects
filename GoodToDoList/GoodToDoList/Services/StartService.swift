//
//  StartService.swift
//  GoodToDoList
//
//  Created by Елена Воронцова on 20.11.2024.
//

import UIKit

final class StartService {
    var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
        configureWindow()
    }
    
    func configureWindow() {
        if let win = window {
            let navigationController = UINavigationController(rootViewController: TaskListViewController())
            
            navigationController.navigationBar.isTranslucent = false
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
            
            win.rootViewController = navigationController
            win.makeKeyAndVisible()
        }
    }
}