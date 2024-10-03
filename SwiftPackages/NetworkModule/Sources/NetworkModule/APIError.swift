//
//  File 2.swift
//  
//
//  Created by J Andrean on 29/03/24.
//

import Foundation

public enum APIError: Error {
    case urlError
    case dataError
    case responseError
    case unknownError
    case decodeError
}
