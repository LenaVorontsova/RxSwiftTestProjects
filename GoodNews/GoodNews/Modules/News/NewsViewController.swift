//
//  NewsViewController.swift
//  GoodNews
//
//  Created by Елена Воронцова on 25.11.2024.
//

import UIKit

final class NewsViewController: UIViewController {
    private lazy var mainView = NewsView(delegate: self)
    
    override func loadView() {
        super.loadView()
        
        self.view = self.mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainView.newsTableView.dataSource = self
        self.mainView.newsTableView.delegate = self
        self.mainView.newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        setup()
    }
    
    private func setup() {
        self.title = "Good news"
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e5642ec49a244ad98f0a81772729d70c") else { return }
        
//        WebService().getArticles(url: url) { articles in
//            guard let articles = articles else { return }
//            self.articleListVM = ArticleListViewModel(articles: articles)
//            
//            DispatchQueue.main.async {
//                self.mainView.newsTableView.reloadData()
//            }
//        }
    }
}

extension NewsViewController: NewsViewProtocol { }

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
            1 //articleListVM?.numberOfSections ?? 0
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            10 // articleListVM?.numberOfRowsIntSection(section) ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NewsTableViewCell.identifier,
                for: indexPath
            ) as? NewsTableViewCell else { fatalError("NewsTableViewCell not found") }

//            let articleVM = articleListVM?.articleAtIndex(indexPath.row)
//            cell.configure(title: articleVM?.title ?? "",
                           description: articleVM?.description ?? "")
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UITableView.automaticDimension
        }
}
