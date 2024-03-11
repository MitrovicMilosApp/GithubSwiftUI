//
//  GithubResponseMapper.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct GithubResponseMapper {
    
    // NOTE - we would handle more errors here

    private static func mapResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        if (200..<300) ~= response.statusCode {
            return (try JSONDecoder().decode(T.self, from: data))
        } else {
            throw ErrorFactory.createWith(statusCode: response.statusCode)
        }
    }
    
    // NOTE - we could make this generic in the future, or break it down to multiple files and keep it typed
    
    static func mapUser(data: Data, response: HTTPURLResponse) throws -> GithubUserDTO {
        return try mapResponse(data: data, response: response)
    }
    
    static func mapRepositories(data: Data, response: HTTPURLResponse) throws -> [GithubRepositoryDTO] {
        return try mapResponse(data: data, response: response)
    }
    
    static func mapBranches(data: Data, response: HTTPURLResponse) throws -> [GithubBranchDTO] {
        return try mapResponse(data: data, response: response)
    }
    
    static func mapCommits(data: Data, response: HTTPURLResponse) throws -> [GithubCommitDTO] {
        return try mapResponse(data: data, response: response)
    }
    
}
