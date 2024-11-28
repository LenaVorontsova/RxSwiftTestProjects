//
//  WeatherView.swift
//  GoodWeather
//
//  Created by Елена Воронцова on 28.11.2024.
//

import UIKit

protocol WeatherViewProtocol: AnyObject { }

final class WeatherView: UIView {
    public lazy var cityNameTextField: UITextField = {
        let view = UITextField()
        view.layer.borderColor = UIColor.brown.cgColor
        view.layer.borderWidth = 0.5
        view.textColor = .black
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    public lazy var temperatureLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 38)
        view.textColor = .black
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    public lazy var humidityLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 26)
        view.textColor = .darkGray
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: WeatherViewProtocol?
    
    init(delegate: WeatherViewProtocol?) {
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
        self.addSubview(cityNameTextField)
        self.addSubview(temperatureLabel)
        self.addSubview(humidityLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cityNameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            cityNameTextField.widthAnchor.constraint(equalToConstant: 200),
            cityNameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            humidityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 40),
            humidityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

}
