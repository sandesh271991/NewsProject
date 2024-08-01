//
//  ArticleRow.swift
//  NewsProject
//
//  Created by Sandesh Sardar on 01/08/24.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article
    
    var body: some View {
        HStack {
            if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(article.title)
                    .font(.headline)
                Text(article.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
