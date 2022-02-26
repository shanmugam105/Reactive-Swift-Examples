//
//  NetworkService.swift
//  Network-Call-Using-Reactive-Swift
//
//  Created by Mac on 26/02/22.
//

import Foundation
import RxSwift

extension NetworkService {
    // MARK: - Get User List
    func makeRequestForUserList() -> Observable<Result<[User], Error>> {
        return request(route: .user, type: [User].self)
    }
    
    // MARK: - Get User's Blog Post Details
    func makeRequestForUserBlogPost(parameter: [String: Any]?) -> Observable<Result<PostDetail, Error>> {
        return request(route: .posts, method: .POST, parameter: parameter, type: PostDetail.self)
    }
}
