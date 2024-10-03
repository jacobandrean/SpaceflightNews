//
//  File.swift
//  
//
//  Created by J Andrean on 31/03/24.
//

import Foundation

public enum LoggingLevel {
    case verbose
    case info
    case succeed
    case warning
    case alert
    case error
    
    var icon: String {
        switch self {
        case .verbose:
            return "🟣"
        case .info:
            return "🔵"
        case .succeed:
            return "🟢"
        case .warning:
            return "🟡"
        case .alert:
            return "🟠"
        case .error:
            return "🔴"
        }
    }
}

public func consoleLog(
    _ level: LoggingLevel,
    file: String = #fileID,
    function: String = #function,
    line: Int = #line,
    message messages: Any?...
) {
    let currentTime = Date()//.dateString("HH:mm:ss.SSS")
    let location = "\(function) in \(file) at line \(line)"
    print("\(level.icon) \(currentTime) \(location) \(messages)")
}
