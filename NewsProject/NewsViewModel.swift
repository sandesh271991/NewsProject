//
//  NewsViewModel.swift
//  NewsProject
//
//  Created by Sandesh Sardar on 28/07/24.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var bookmarks: [Article] = []
    @Published var category: String = "general"
    
    private let newsService: NewsService
    
    init(newsService: NewsService = NewsService()) {
        self.newsService = newsService
        fetchArticles()
    }
    
    func fetchArticles() {
        newsService.fetchArticles(for: category) { [weak self] articles in
            self?.articles = articles ?? []
        }
    }
    
    func bookmark(article: Article) {
        if !bookmarks.contains(where: { $0.id == article.id }) {
            bookmarks.append(article)
        }
    }
    
    func removeBookmark(article: Article) {
        if let index = bookmarks.firstIndex(where: { $0.id == article.id }) {
            bookmarks.remove(at: index)
        }
    }
}
