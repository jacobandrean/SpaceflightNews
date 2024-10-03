//
//  File.swift
//  
//
//  Created by Jacob Andrean on 01/10/24.
//

import Combine
import Foundation
import NetworkModule

public enum NewsType {
    case article, blog, report
}

public protocol NewsService {
    func getNews(type: NewsType) -> AnyPublisher<NewsResponse, Error>
}

class NewsAPI: BaseAPI, NewsService {
    func getNews(type: NewsType) -> AnyPublisher<NewsResponse, Error> {
        let path: String
        switch type {
        case .article:
            path = "/v4/articles"
        case .blog:
            path = "/v4/blogs"
        case .report:
            path = "/v4/reports"
        }
        return request(.get, path: path)
    }
}
