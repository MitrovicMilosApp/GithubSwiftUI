//
//  GithubCommit.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct GithubCommit: Codable {
    let committer: String?
    let committerEmail: String?
    let message: String?
    let id: String
    
    init(dtoObject: GithubCommitDTO) {
        self.committer = dtoObject.commit.committer.name
        self.committerEmail = dtoObject.commit.committer.email
        self.message = dtoObject.commit.message
        self.id = dtoObject.sha
    }
}
