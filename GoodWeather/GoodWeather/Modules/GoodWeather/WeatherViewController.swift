//
//  WeatherViewController.swift
//  GoodWeather
//
//  Created by Елена Воронцова on 28.11.2024.
//

import UIKit
import RxCocoa
import RxSwift

final class WeatherViewController: UIViewController {
    private lazy var mainView = WeatherView(delegate: self)
    
    private let disposeBag = DisposeBag()
    
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
        
        self.mainView.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.mainView.cityNameTextField.text }
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.mainView.temperatureLabel.text = "\(weather.temp) ℉"
            self.mainView.humidityLabel.text = "\(weather.humidity) 💧"
        } else {
            self.mainView.temperatureLabel.text = "🙈"
            self.mainView.humidityLabel.text = "✕"
        }
    }
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        
        let resource = Resource<WeatherResult>(url: url)
        
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .asDriver(onErrorJustReturn: WeatherResult.empty)
        
        search.map { "\($0.main.temp) ℉" }
            .drive(self.mainView.temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity) 💧" }
            .drive(self.mainView.humidityLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

extension WeatherViewController: WeatherViewProtocol { }
