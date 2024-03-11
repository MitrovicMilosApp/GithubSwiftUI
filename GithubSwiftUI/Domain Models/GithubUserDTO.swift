//
//  GithubUserDTO.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct GithubUserDTO: Codable {
    let name: String?
    let company: String?
    let avatar_url: String?
    let login: String
    let public_repos: Int?
}
