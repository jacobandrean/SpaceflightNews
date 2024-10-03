//
//  File.swift
//  
//
//  Created by J Andrean on 29/03/24.
//

import Foundation
import UtilityModule

public class Injector {
    public static let shared: Injector = .init()
    
    private var dependencies: [(key: String, value: Any)] = []
    
    public func register(module: Module) {
        module.register(for: .shared)
    }
    
    public func register<T>(_ dependency: Any, for type: T.Type) {
        let key = String(describing: type)
        dependencies.append((key: key, value: dependency))
        consoleLog(.info, message: "registering \(key)", dependency)
    }
    
    public func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies.first(where: { $0.key == key && $0.value is T })
        
        guard let matchDependency = dependency?.value as? T else {
            consoleLog(.error, message: "trying find", key, "in", dependencies)
            fatalError("missing dependency \(key)")
        }
        consoleLog(.info, message: "resolving \(key)", matchDependency)
        return matchDependency
    }
}
