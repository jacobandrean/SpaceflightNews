//
//  File.swift
//  
//
//  Created by Jacob Andrean on 28/09/24.
//

import Foundation

public struct NewsResponse: Codable {
    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [ResultResponse]
}

public struct ResultResponse: Codable {
    public let id: Int
    public let title: String
    public let url: String
    public let imageUrl: String
    public let newsSite: String
    public let summary: String
    public let publishedAt: String
    public let updatedAt: String
    public let featured: Bool?
    public let launches: [LaunchResponse]?
    public let events: [EventResponse]?

    enum CodingKeys: String, CodingKey {
        case id, title, url, summary, featured, launches, events
        case imageUrl = "image_url"
        case newsSite = "news_site"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
    }
}

public struct LaunchResponse: Codable {
    public let launchId: String
    public let provider: String

    enum CodingKeys: String, CodingKey {
        case launchId = "launch_id"
        case provider
    }
}

public struct EventResponse: Codable {
    public let eventId: Int
    public let provider: String

    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case provider
    }
}
