//
//  NewsRow.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import SwiftUI
// News Row - common for Favorites and news
struct NewsRow: View {
    let article: Article

    var body: some View {
        HStack(alignment: .top) {
            // Thumbnail Image
            if let urlImage = article.urlToImage, let url = URL(string: urlImage) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                } placeholder: {
                    Color.gray
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                }
            } else {
                Color.gray
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
            }

            // Article Title and Description
            VStack(alignment: .leading, spacing: 5) {
                Text(article.title ?? "No Title")
                    .font(.headline)
                    .fontWeight(.bold)
                    .accessibilityIdentifier("articleTitle_\(article.title ?? "No Title")")

                if let description = article.description, !description.isEmpty {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityIdentifier("articleDescription_\(description)")
                }
            }
        }
    }
}
