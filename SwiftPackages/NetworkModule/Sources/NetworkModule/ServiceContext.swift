//
//  File.swift
//  
//
//  Created by J Andrean on 29/03/24.
//

import Foundation

public protocol ServiceContext {
    var urlString: String { get }
    var defaultHeader: [String: String] { get }
}

public class AppServiceContext: ServiceContext {
    public var urlString: String
    public var defaultHeader: [String : String]
    
    public init(urlString: String, defaultHeader: [String : String]) {
        self.urlString = urlString
        self.defaultHeader = defaultHeader
    }
}
