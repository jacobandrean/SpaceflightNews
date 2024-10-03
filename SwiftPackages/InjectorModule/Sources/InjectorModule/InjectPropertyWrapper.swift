//
//  File.swift
//  
//
//  Created by J Andrean on 29/03/24.
//

import Foundation

@propertyWrapper
public struct Inject<T> {
    private let injector: Injector = .shared
    private var value: T
    
    public var wrappedValue: T {
        get { value }
        set { value = newValue }
    }
    
    public init() {
        self.value = injector.resolve()
    }
}
