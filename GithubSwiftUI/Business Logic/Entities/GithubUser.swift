//
//  GithubUser.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

// NOTE - all of the entities are mapped to fit our iOS app needs, and also separated from the domain models so that we can keep things decoupled and easy to change

struct GithubUser: Codable, Hashable {
    let name: String?
    let company: String?
    let avatar_url: String?
    let username: String
    let public_repos: Int?
    
    init(dtoObject: GithubUserDTO) {
        self.name = dtoObject.name
        self.company = dtoObject.company
        self.avatar_url = dtoObject.avatar_url
        self.username = dtoObject.login
        self.public_repos = dtoObject.public_repos
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(username)
    }
}
