//
//  NewsListView.swift
//  NewsDemo
//
//  Created by Dineshkumar on 19/01/25.
//
import SwiftUI

struct NewsListView: View {
    @State private var selectedSegment: StringConstants.Segments = .News
    @State private var searchText = ""
    @State private var favoriteArticles: [Article] = []
    @StateObject var viewModel = NewsListVM()

    var body: some View {
        NavigationView {
            VStack {
                // Segmented Picker
                Picker("", selection: $selectedSegment) {
                    ForEach(StringConstants.Segments.allCases, id: \.self) { segment in
                        Text(segment.rawValue).tag(segment)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selectedSegment) {
                    if selectedSegment == .Favorites {
                        favoriteArticles = FavoritesManager.shared.fetchFavorites()
                    } else {
                        viewModel.fetchNews()
                    }
                    // Clear search text when switching segments
                    searchText = ""
                }

                // Search bar (only for "News")
                if selectedSegment == .News {
                    TextField(StringConstants.SearchArticle, text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 15)
                        .padding(.top, 5)
                        .onChange(of: searchText) {
                            // Update search
                            viewModel.searchNews(with: searchText)
                        }
                }

                // Content Section
                if selectedSegment == .News {
                    if let articles = viewModel.news?.articles, !articles.isEmpty {
                        List(articles, id: \.self) { article in
                            NavigationLink(destination: NewsDetailView(article: article)) {
                                NewsRow(article: article)
                            }
                        }
                        .listStyle(PlainListStyle())
                    } else if viewModel.errorMessage != nil {
                        Spacer()
                        Text(viewModel.errorMessage ?? StringConstants.NoArticle)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding()
                        Spacer()
                    } else {
                        NoArticlesView()
                    }
                } else {
                    // Favorites
                    if favoriteArticles.isEmpty {
                        NoArticlesView()
                    } else {
                        List(favoriteArticles, id: \.self) { article in
                            NavigationLink(destination: NewsDetailView(article: article)) {
                                NewsRow(article: article)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationTitle(StringConstants.AppTitle)
            .onAppear {
                if selectedSegment == .Favorites {
                    favoriteArticles = FavoritesManager.shared.fetchFavorites()
                } else {
                    viewModel.fetchNews()
                }
            }
        }
    }
}

