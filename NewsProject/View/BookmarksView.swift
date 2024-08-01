//
//  BookmarksView.swift
//  NewsProject
//
//  Created by Sandesh Sardar on 01/08/24.
//

import SwiftUI

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
