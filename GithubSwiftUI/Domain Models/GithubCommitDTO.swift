//
//  GithubCommitDTO.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct GithubCommitDTO: Codable {
    let sha: String
    let commit: CommitDTO
}

struct CommitDTO: Codable {
    let committer: CommiterDTO
    let message: String?
}

struct CommiterDTO: Codable {
    let name: String?
    let email: String?
}
