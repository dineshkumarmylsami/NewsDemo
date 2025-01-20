//
//  NewsDetailView.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import SwiftUI
/// News Detail View
struct NewsDetailView: View {
    let article: Article
    @State private var isFavorite: Bool = false
    var viewModel:NewsDetailVM = NewsDetailVM()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Thumbnail Image
                if let url = article.urlToImage, let imageUrl = URL(string: url) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(maxHeight: 300)
                }

                // Title
                Text(article.title ?? "")
                    .font(.title)
                    .bold()

                // Author and Published Date
                HStack {
                    if let author = article.author, !author.isEmpty {
                        Text("\(StringConstants.authorByTitle) \(author)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if let publishedAt = article.publishedAt {
                        Text(FormatHelper.formattedDate(from: publishedAt))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .italic()
                    }
                }

                Divider()

                // Description
                if let description = article.description {
                    Text(description)
                        .font(.body)
                        .padding(.top, 5)
                }

                // Full Content
                if let content = article.content {
                    Text(content)
                        .font(.body)
                        .padding(.top, 10)
                }
            }
            .padding()
        }
        .navigationTitle(StringConstants.DetailsTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            isFavorite = viewModel.toggleFavorite(isFavorite: isFavorite, article: article)
        }) {
            Image(systemName: isFavorite ? StringConstants.heartFill : StringConstants.heartEmpty)
                .foregroundColor(isFavorite ? .red : .gray)
        })
        .onAppear {
            isFavorite = FavoritesManager.shared.fetchFavorites().contains(where: { $0.title == article.title })
        }
    }
}
