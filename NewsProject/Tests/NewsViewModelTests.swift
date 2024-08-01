//
//  NewsViewModelTests.swift
//  NewsProjectTests
//
//  Created by Sandesh Sardar on 28/07/24.
//

import XCTest
@testable import NewsProject

class NewsViewModelTests: XCTestCase {
    
    var viewModel: NewsViewModel!
    var mockNewsService: MockNewsService!
    
    override func setUpWithError() throws {
        mockNewsService = MockNewsService()
        viewModel = NewsViewModel(newsService: mockNewsService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockNewsService = nil
    }
    
    func testFetchArticles() throws {
        // Given
        let expectedArticles = [
            Article(
                title: "Test Title",
                description: "Test Description",
                content: "Test Content",
                url: "https://testurl.com",
                urlToImage: "https://testurl.com/image.jpg",
                publishedAt: "2021-10-01",
                source: Article.Source(name: "Test Source")
            )
        ]
        
        mockNewsService.mockArticles = expectedArticles
        
        // When
        viewModel.fetchArticles()
        
        // Then
        XCTAssertEqual(viewModel.articles.count, expectedArticles.count)
        XCTAssertEqual(viewModel.articles.first?.title, expectedArticles.first?.title)
    }
    
    func testBookmarkArticle() throws {
        // Given
        let article = Article(
            title: "Test Title",
            description: "Test Description",
            content: "Test Content",
            url: "https://testurl.com",
            urlToImage: "https://testurl.com/image.jpg",
            publishedAt: "2021-10-01",
            source: Article.Source(name: "Test Source")
        )
        
        // When
        viewModel.bookmark(article: article)
        
        // Then
        XCTAssertTrue(viewModel.bookmarks.contains(where: { $0.id == article.id }))
    }
    
    func testRemoveBookmark() throws {
        // Given
        let article = Article(
            title: "Test Title",
            description: "Test Description",
            content: "Test Content",
            url: "https://testurl.com",
            urlToImage: "https://testurl.com/image.jpg",
            publishedAt: "2021-10-01",
            source: Article.Source(name: "Test Source")
        )
        
        viewModel.bookmark(article: article)
        
        // When
        viewModel.removeBookmark(article: article)
        
        // Then
        XCTAssertFalse(viewModel.bookmarks.contains(where: { $0.id == article.id }))
    }
}

// Mock service for unit testing
class MockNewsService: NewsService {
    
    var mockArticles: [Article]?
    
    override func fetchArticles(for category: String, completion: @escaping ([Article]?) -> Void) {
        completion(mockArticles)
    }
}

