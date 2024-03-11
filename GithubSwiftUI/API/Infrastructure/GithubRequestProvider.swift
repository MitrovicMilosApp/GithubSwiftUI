//
//  GithubRequestProvider.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct GithubRequestProvider {
    
    // NOTE: Here we would add more methods, such as makeRequest(path: String, method: HTTPMethod, body: BodyModel), or uploadFile. We could also make it generic.
    
    static func makeRequest(path: String, method: HTTPMethod) -> URLRequest {
        guard let url = URL(string: path) else {
            preconditionFailure("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
