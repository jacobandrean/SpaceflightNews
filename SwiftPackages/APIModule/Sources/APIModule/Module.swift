//
//  File.swift
//  
//
//  Created by J Andrean on 29/03/24.
//

import Foundation
import InjectorModule

public struct Module: InjectorModule.Module {
    public init() {}
    
    public func register(for injector: Injector) {
        injector.register(NewsAPI(), for: NewsService.self)
    }
}
