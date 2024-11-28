//
//  WeatherViewController.swift
//  GoodWeather
//
//  Created by Елена Воронцова on 28.11.2024.
//

import UIKit

final class WeatherViewController: UIViewController {
    private lazy var mainView = WeatherView(delegate: self)
    
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
        self.title = "Weather"
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
    }
}

extension WeatherViewController: WeatherViewProtocol { }
