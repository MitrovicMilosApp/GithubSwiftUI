//
//  GithubAPIPathProvider.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct GithubAPIPathProvider {
    
    // NOTE: this could have been done using enum with associated values, however, this struct might need to be broken down and extended into separate files, which handled as an enum could break the open-closed principle. It is now separated in extensions for showcasing.
    
    // NOTE: inside GithubRequestProvider we use predonditionFailure if any of these paths do not create URL. In a real wolrd scenario, I would either handle failure better, or I would make the paths into an enum and test the entire enum combined with the github username validator. That way we would ensure it always passes the precondition, while enum would force us to handle all of the cases, removing space for human error

    
    private static let base = "https://api.github.com"
    private static func paginationQueryString(page: Int, pageSize: Int) -> String {
        "?page=\(page)&per_page=\(pageSize)"
    }
}

extension GithubAPIPathProvider {
    struct UserData {
        private static let userBase = "\(base)/users"
        
        static func user(_ username: String) -> String {
            "\(userBase)/\(username)"
        }
        
        static func repos(forUser username: String, page: Int, pageSize: Int) -> String {
            "\(userBase)/\(username)/repos" + paginationQueryString(page: page, pageSize: pageSize)
        }
    }
}

extension GithubAPIPathProvider {
    struct RepositoryData {
        private static let repositoryBase = "\(base)/repos"
        
        static func branches(forUser username: String, repository: String, page: Int, pageSize: Int) -> String {
            "\(repositoryBase)/\(username)/\(repository)/branches" + paginationQueryString(page: page, pageSize: pageSize)
        }
        
        static func allCommits(forUser username: String, repository: String, page: Int, pageSize: Int) -> String {
            "\(repositoryBase)/\(username)/\(repository)/commits" + paginationQueryString(page: page, pageSize: pageSize)
        }
        
        static func commitsForBranch(forUser username: String, repository: String, branch: String, page: Int, pageSize: Int) -> String {
            allCommits(forUser: username, repository: repository, page: page, pageSize: pageSize) + "&sha=\(branch)"
        }
    }
}
