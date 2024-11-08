//
//  MainView.swift
//  CameraFilter
//
//  Created by Елена Воронцова on 08.11.2024.
//

import UIKit

protocol MainDelegate: AnyObject {
    func applyFilter()
}

final class MainView: UIView {
    private lazy var filterImage: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var filterButton: UIButton = {
        let view = UIButton()
        view.setTitle("Apply Filter", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 5
        view.backgroundColor = .systemBlue
        view.setTitleColor(.black, for: .normal)
        
        view.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: MainDelegate?
    
    init(delegate: MainDelegate?) {
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
        self.addSubview(filterImage)
        self.addSubview(filterButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            filterImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                             constant: 20),
            filterImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 20),
            filterImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -20),
            filterImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            filterButton.topAnchor.constraint(equalTo: filterImage.bottomAnchor, constant: 20),
            filterButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: 80),
            filterButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -80),
            filterButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func applyFilter() {
        delegate?.applyFilter()
    }
}
