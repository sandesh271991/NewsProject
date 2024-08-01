//
//  ArticleDetailView.swift
//  NewsProject
//
//  Created by Sandesh Sardar on 01/08/24.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: Article
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 200)
                    .cornerRadius(8)
                }
                Text(article.title)
                    .font(.title)
                    .padding(.top)
                Text(article.description ?? "")
                    .font(.body)
                Text(article.content ?? "")
                    .font(.body)
                
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.bookmark(article: article)
                    }) {
                        Text("Bookmark")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
        }
        .navigationTitle(article.source.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
