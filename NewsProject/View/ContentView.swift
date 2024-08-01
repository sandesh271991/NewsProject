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
