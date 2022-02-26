//
//  NetworkService.swift
//  Network-Call-Using-Reactive-Swift
//
//  Created by Mac on 26/02/22.
//

import Foundation

extension NetworkService {
    // MARK: - Get User List
    func makeRequestForUserList(completion: @escaping (Result<[User], Error>) -> Void) {
        request(route: .user, type: [User].self,completion: completion)
    }
    
    // MARK: - Get User's Blog Post Details
    func makeRequestForUserBlogPost(parameter: [String: Any]?, completion: @escaping (Result<PostDetail, Error>) -> Void) {
        request(route: .posts, method: .POST, parameter: parameter, type: PostDetail.self,completion: completion)
    }
}
