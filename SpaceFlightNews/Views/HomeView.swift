//
//  HomeView.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 01/10/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    @State private var showingDetailedList = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text(newsVM.currentTimeGreeting)
                .font(.title)
                .multilineTextAlignment(.center)
            HorizontalListView(category: .article, news: newsVM.articles)
            HorizontalListView(category: .blog, news: newsVM.blogs)
            HorizontalListView(category: .report, news: newsVM.reports)
            Spacer()
        }
        .padding()
        .onAppear {
            newsVM.getAllNews()
        }
    }
    
    @ViewBuilder
    func HorizontalListView(
        category: NewsCategory,
        news: [News]
    ) -> some View {
        VStack {
            if !news.isEmpty {
                HStack {
                    Text(category.name)
                        .font(.subheadline)
                    Spacer()
                    Button("see more") {
                        newsVM.selectSeeMore(for: category)
                        showingDetailedList = true
                    }
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(news) { item in
                        AsyncImage(url: URL(string: item.imageUrl)) { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .border(.black)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 100, height: 100)
                                .background(.gray.opacity(0.5))
                                .border(.black)
                        }
                    }
                }
                .frame(height: 100)
            }
        }
        .navigationDestination(isPresented: $showingDetailedList) {
            DetailedListView()
                .environmentObject(newsVM)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
