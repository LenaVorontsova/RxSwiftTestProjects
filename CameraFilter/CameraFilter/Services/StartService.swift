//
//  StartService.swift
//  CameraFilter
//
//  Created by Елена Воронцова on 08.11.2024.
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
            let navigationController = UINavigationController(rootViewController: ViewController())
            win.rootViewController = navigationController
            win.makeKeyAndVisible()
        }
    }
}
