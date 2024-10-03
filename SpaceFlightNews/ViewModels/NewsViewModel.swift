//
//  NewsViewModel.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 01/10/24.
//

import APIModule
import Combine
import InjectorModule
import Foundation
import SwiftUI
import UtilityModule

enum SortType: CaseIterable {
    case asc, desc
    
    var name: String {
        switch self {
        case .asc:
            return "Ascending"
        case .desc:
            return "Descending"
        }
    }
}

class NewsViewModel: ObservableObject {
    @Inject var newsService: NewsService
    let authManager = AuthManager.shared
    @Published var articles: [News] = []
    @Published var blogs: [News] = []
    @Published var reports: [News] = []
    @Published var selectedCategory: NewsCategory?
    @Published var detailedNewsList: [News] = []
    @Published var searchedNewsList: [News] = []
    @Published var searchText: String = ""
    @Published var selectedSortType: SortType?
    
    private var cancellables = [AnyCancellable]()
    
    var currentTimeGreeting: String {
        let name = authManager.profile?.name ?? ""
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12:
            return "Good Morning\n\(name)"
        case 12..<18:
            return "Good Afternoon\n\(name)"
        default:
            return "Good Evening\n\(name)"
        }
    }
    
    func searchNews(_ text: String) {
        guard !text.isEmpty else { return }
        searchedNewsList = detailedNewsList.filter { $0.title.lowercased().contains(text.lowercased()) }
    }
    
    func sortNews(by sortType: SortType?) {
        selectedSortType = sortType
        let sortFunction: (News, News) -> Bool = {
            switch sortType {
            case .asc:
                return $0.title < $1.title
            case .desc:
                return $0.title > $1.title
            case .none:
                return false
            }
        }
        detailedNewsList.sort(by: sortFunction)
    }
    
    func selectSeeMore(for category: NewsCategory?) {
        guard let category else { return }
        selectedCategory = category
        switch category {
        case .article:
            detailedNewsList = articles
        case .blog:
            detailedNewsList = blogs
        case .report:
            detailedNewsList = reports
        }
    }
    
    func getAllNews() {
        getArticles()
        getBlogs()
        getReports()
    }
    
    private func getArticles() {
        newsService.getNews(type: .article)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        consoleLog(.info, message: "Finished")
                    case .failure(let error):
                        consoleLog(.error, message: error)
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self else { return }
                    self.articles = response.results.map { .init(response: $0) }
                }
            )
            .store(in: &cancellables)
    }
    
    private func getBlogs() {
        newsService.getNews(type: .blog)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        consoleLog(.info, message: "Finished")
                    case .failure(let error):
                        consoleLog(.error, message: error)
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self else { return }
                    self.blogs = response.results.map { .init(response: $0) }
                }
            )
            .store(in: &cancellables)
    }
    
    private func getReports() {
        newsService.getNews(type: .report)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        consoleLog(.info, message: "Finished")
                    case .failure(let error):
                        consoleLog(.error, message: error)
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self else { return }
                    self.reports = response.results.map { .init(response: $0) }
                }
            )
            .store(in: &cancellables)
    }
}
