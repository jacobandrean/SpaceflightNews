//
//  News.swift
//  SpaceFlightNews
//
//  Created by Jacob Andrean on 01/10/24.
//

import APIModule
import Foundation

enum NewsCategory {
    case article, blog, report
    
    var name: String {
        switch self {
        case .article: return "Articles"
        case .blog: return "Blogs"
        case .report: return "Reports"
        }
    }
}

struct News: Identifiable {
    let uuid = UUID()
    let id: Int
    let title: String
    let imageUrl: String
//    let launches: [NewsLaunch]
    
    init(response: ResultResponse) {
        self.id = response.id
        self.title = response.title
        self.imageUrl = response.imageUrl
    }
}

struct NewsLaunch {
    let launchId: String
    let provider: String
}
