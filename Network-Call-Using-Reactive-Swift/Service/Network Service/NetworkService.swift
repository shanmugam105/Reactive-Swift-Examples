//
//  NetworkService.swift
//  Network-Call-Practice
//
//  Created by ADMIN on 19/06/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import Foundation

final class NetworkService: NSObject {
    static let shared = NetworkService()
    
    private override init() {}

    func request<T: Codable>(route: Route,
                             method: HTTPMethod = .GET,
                             parameter: [String: Any]? = nil,
                             type: T.Type,
                             completion: @escaping (Result<T, Error>) -> Void) {
        let request = createRequest(route: route, method: method, parameter: parameter)
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            
            if let data = data {
                let responseString = String(data: data, encoding: .utf8) ?? "Unable to convert as string."
                print("Response is:-------> \(responseString)")
                
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(.success(result))
                } catch {
                    print("Error is:-------> \(ValidationError.parsingError.localizedDescription)")
                    completion(.failure(ValidationError.parsingError))
                }
            } else if let error = error {
                print("Error is:-------> \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    /// This function helps to create URLRequest
    /// - Parameters:
    ///   - route: Backend resource path
    ///   - method: Type of HTTP Request
    ///   - parameter: Need to pass to backend
    /// - Returns: It returns URLRequest
    private func createRequest(route: Route,
                               method: HTTPMethod = .GET,
                               parameter: [String: Any]? = nil) -> URLRequest {
        let urlString = Route.baseURL + route.description
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameter {
            switch method {
            case .GET:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map {URLQueryItem(name: $0, value: "\($1)")}
                
                urlRequest.url = urlComponent?.url
            case .POST, .DELETE, .PATCH:
                let bodyData = try? JSONSerialization.data(withJSONObject: params,
                                                           options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}