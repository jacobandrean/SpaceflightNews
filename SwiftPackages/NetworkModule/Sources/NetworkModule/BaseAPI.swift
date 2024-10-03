//
//  File 3.swift
//  
//
//  Created by J Andrean on 29/03/24.
//

import Combine
import Foundation
import InjectorModule
import UtilityModule

public protocol BaseAPI {
//    var context: ServiceContext? { get set }
//    var baseURLString: String { get }
}

public extension BaseAPI {
    var context: ServiceContext { Injector.shared.resolve() }
    var session: URLSession { URLSession.shared }
    var baseURLString: String { context.urlString }
    var defaultHeader: [String: String] { context.defaultHeader }
    
    // MARK: - Combine Session
    private func errorPublisher<T>(_ error: APIError) -> AnyPublisher<T, Error> {
        return Fail(error: error).eraseToAnyPublisher()
    }
    
    func request<Response: Codable>(
        _ method: HTTPMethod,
        path: String,
        headers: [String: String] = [:],
        parameters: [String: Any] = [:]) -> AnyPublisher<Response, Error>
//        parameters: [String: Any] = [:]) -> AnyPublisher<BaseResponse<Response>, Error>
    {
        guard var urlComponents = URLComponents(string: baseURLString) else {
            return errorPublisher(.urlError)
        }
        
        urlComponents.path = path
        urlComponents.queryItems = parameters
            .map { parameter -> URLQueryItem in
                return .init(
                    name: parameter.key,
                    value: "\(parameter.value)"
                )
            }
        
        guard let url = urlComponents.url else {
            return errorPublisher(.urlError)
        }
        consoleLog(.info, message: url)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        defaultHeader.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        headers.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    consoleLog(.error, message: "Response: \(response as? HTTPURLResponse)")
                    throw APIError.responseError
                }
                
                consoleLog(.info, message: "HTTPResponse: \(httpResponse)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    consoleLog(.info, message: "Response Error JSON: \(jsonString)")
                } else {
                    consoleLog(.error, message: "Response Error: Unable to decode data")
                }
                
                return data
            }
            .decode(type: Response.self, decoder: JSONDecoder())
//            .decode(type: BaseResponse<Response>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

//MARK: - Partss of URL
/*
 URL = https://www.example.co.uk:443/blog/search?docid=720#dayone
    https://        = scheme
    www.            = subdomain
    example.        = domain
    co.uk           = top level domain
    :443            = port number
    /blog/search    = path
    ?               = query string /parameter separator
    docid=720       = query string / parameter
    #dayone         = fragment
 */

/*
 func request<Response: Codable>(
     _ method: HTTPMethod,
     path: String,
     headers: [String: String] = [:],
     parameters: [String: Any] = [:],
     fileURL: URL? = nil // Add fileURL to support file uploads
 ) -> AnyPublisher<Response, Error> {
     guard var urlComponents = URLComponents(string: baseURLString) else {
         return errorPublisher(.urlError)
     }
     
     urlComponents.path = path
     
     // Check if there is a file to upload
     if method == .post, let fileURL = fileURL {
         var request = URLRequest(url: urlComponents.url!)
         request.httpMethod = method.rawValue

         let boundary = UUID().uuidString
         request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

         var body = Data()

         // Add file data
         let videoData = try? Data(contentsOf: fileURL)
         let videoFileName = fileURL.lastPathComponent
         let mimeType = "video/mov" // Change according to your video type

         body.append("--\(boundary)\r\n")
         body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(videoFileName)\"\r\n")
         body.append("Content-Type: \(mimeType)\r\n\r\n")
         body.append(videoData!)
         body.append("\r\n")

         // Add other parameters
         for (key, value) in parameters {
             body.append("--\(boundary)\r\n")
             body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
             body.append("\(value)\r\n")
         }

         // Close the body
         body.append("--\(boundary)--\r\n")
         request.httpBody = body

         return session.dataTaskPublisher(for: request)
             .subscribe(on: DispatchQueue.global(qos: .background))
             .tryMap { data, response -> Data in
                 guard let httpResponse = response as? HTTPURLResponse,
                       (200...299).contains(httpResponse.statusCode) else {
                     consoleLog(.error, message: "Response: \(response as? HTTPURLResponse)")
                     throw APIError.responseError
                 }
                 return data
             }
             .decode(type: Response.self, decoder: JSONDecoder())
             .eraseToAnyPublisher()
     } else {
         // Handle GET and other requests normally
         guard let url = urlComponents.url else {
             return errorPublisher(.urlError)
         }
         
         var urlRequest = URLRequest(url: url)
         urlRequest.httpMethod = method.rawValue
         
         defaultHeader.forEach {
             urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
         }
         headers.forEach {
             urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
         }
         
         return session.dataTaskPublisher(for: urlRequest)
             .subscribe(on: DispatchQueue.global(qos: .background))
             .tryMap { data, response -> Data in
                 guard let httpResponse = response as? HTTPURLResponse,
                       (200...299).contains(httpResponse.statusCode) else {
                     consoleLog(.error, message: "Response: \(response as? HTTPURLResponse)")
                     throw APIError.responseError
                 }
                 return data
             }
             .decode(type: Response.self, decoder: JSONDecoder())
             .eraseToAnyPublisher()
     }
 }

 */
