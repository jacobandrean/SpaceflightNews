//
//  DetailedListView.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 01/10/24.
//

import SwiftUI

struct DetailedListView: View {
    @EnvironmentObject var newsVM: NewsViewModel
    @State private var showingSortModal = false
    var body: some View {
        List(newsVM.searchText.isEmpty ? newsVM.detailedNewsList : newsVM.searchedNewsList) { news in
            CardView(news: news)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
        }
        .listStyle(DefaultListStyle())
        .searchable(
            text: $newsVM.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search News"
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingSortModal = true
                }) {
                    Text("Sort")
                }
            }
        }
        .onChange(of: newsVM.searchText) {
            newsVM.searchNews($0)
        }
        .sheet(isPresented: $showingSortModal) {
            SortModalView()
                .presentationDetents([.fraction(0.2)])
        }
        .navigationTitle(newsVM.selectedCategory?.name ?? "")
    }
    
    @ViewBuilder
    func SortModalView() -> some View {
        VStack(alignment: .leading) {
            Text("Sort by")
                .bold()
                .padding(.top)
                .padding(.leading)
            ForEach(SortType.allCases, id: \.self) { sortType in
                RadioButtonView(
                    option: sortType.name,
                    isSelected: sortType == newsVM.selectedSortType
                ) {
                    newsVM.sortNews(by: sortType)
                    showingSortModal = false
                }
                .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder
    func CardView(news: News) -> some View {
        AsyncImage(url: URL(string: news.imageUrl)) { image in
            image
                .resizable()
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .border(.black)
        } placeholder: {
            ProgressView()
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.5))
                .border(.black)
        }
        .overlay(alignment: .bottom) {
            Text(news.title)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.8))
        }
    }
}

struct DetailedListView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedListView()
    }
}
