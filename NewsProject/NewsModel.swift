//
//  NewsModel.swift
//  NewsProject
//
//  Created by Sandesh Sardar on 28/07/24.
//

import Foundation

struct NewsAPIResponse: Codable {
    let articles: [Article]
}

struct Article: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String?
    let content: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let source: Source
    
    struct Source: Codable {
        let name: String
    }
}
