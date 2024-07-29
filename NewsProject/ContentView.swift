//
//  ContentView.swift
//  NewsProject
//
//  Created by Sandesh Sardar on 28/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Category", selection: $viewModel.category) {
                    Text("General").tag("general")
                    Text("Business").tag("business")
                    Text("Technology").tag("technology")
                    Text("Sports").tag("sports")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: viewModel.category) { _ in
                    viewModel.fetchArticles()
                }
                
                List(viewModel.articles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article, viewModel: viewModel)) {
                        ArticleRow(article: article)
                    }
                }
                .navigationTitle("News")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: BookmarksView(viewModel: viewModel)) {
                            Text("Bookmarks")
                        }
                    }
                }
            }
        }
    }
}

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

struct BookmarksView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.bookmarks) { article in
                ArticleRow(article: article)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    viewModel.removeBookmark(article: viewModel.bookmarks[index])
                }
            }
        }
        .navigationTitle("Bookmarks")
    }
}
