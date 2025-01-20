//
//  NoArticleView.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//

import SwiftUI

struct NoArticlesView: View {
    var body: some View {
        Spacer()
        Text(StringConstants.NoArticle)
            .foregroundColor(.gray)
            .font(.subheadline)
            .fontWeight(.light)
        Spacer()
    }
}
