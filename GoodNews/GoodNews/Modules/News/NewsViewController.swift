//
//  NewsViewController.swift
//  GoodNews
//
//  Created by Елена Воронцова on 25.11.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class NewsViewController: UIViewController {
    private lazy var mainView = NewsView(delegate: self)
    
    private let disposeBag = DisposeBag()
    private var articles = [Article]()
    
    override func loadView() {
        super.loadView()
        
        self.view = self.mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        populateNews()
    }
    
    private func setup() {
        self.title = "Good news"
        
        self.mainView.newsTableView.dataSource = self
        self.mainView.newsTableView.delegate = self
        self.mainView.newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    
    private func populateNews() {
        URLRequest.load(resource: ArticlesList.all)
            .subscribe(onNext: { [weak self] result in
                if let result = result {
                    self?.articles = result.articles
                    DispatchQueue.main.async {
                        self?.mainView.newsTableView.reloadData()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}

extension NewsViewController: NewsViewProtocol { }

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
            for: indexPath
        ) as? NewsTableViewCell else { fatalError("NewsTableViewCell not found") }
        
        let article = articles[indexPath.row]
        cell.configure(title: article.title,
                       description: article.description ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
