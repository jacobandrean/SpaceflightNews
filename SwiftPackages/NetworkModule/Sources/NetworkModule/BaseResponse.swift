//
//  File.swift
//  
//
//  Created by J Andrean on 29/03/24.
//

import Foundation

//public typealias APIResponse<Object: Codable> = APIResult<BaseResponse<Object>, ResponseError>

public typealias APIResult<Object: Codable> = Result<BaseResponse<Object>, APIError>

//public protocol HTTPRawBearer: CustomStringConvertible {
//    var rawResponse: HTTPURLResponse? { get }
//    var rawData: Data? { get }
//}

public struct BaseResponse<ResponseData: Codable>: Codable {
//    public let status: Bool?
//    public let success: Bool?
    public let data: ResponseData?
    public let error: ResponseError?
//    public var rawResponse: HTTPURLResponse? = nil
//    public var rawData: Data? = nil
    
//    enum CodingKeys: String, CodingKey {
//        case status, success, data, error
//    }
    
    public init(
//        status: Bool?,
//        success: Bool?,
        data: ResponseData?,
        error: ResponseError?
//        rawResponse: HTTPURLResponse? = nil,
//        rawData: Data? = nil
    ) {
//        self.status = status
//        self.success = success
        self.data = data
        self.error = error
//        self.rawResponse = rawResponse
//        self.rawData = rawData
    }
    
//    public var description: String {
//        if let error = error {
//            return "\(error.localizedDescription)"
//        } else {
//            return rawResponse?.description ?? ""
//        }
//    }
}

public struct ResponseError: Codable, Error {
    public let code: String
    public let message: String
//    public let messageTitle: String
//    public let messageSeverity: String
//    public var rawResponse: HTTPURLResponse? = nil
//    public var rawData: Data? = nil
    
//    enum CodingKeys: String, CodingKey {
//        case code, message, messageTitle, messageSeverity
//    }
    
//    public var description: String {
//        message
//    }
}
