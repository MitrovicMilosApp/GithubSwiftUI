//
//  GithubCommitService.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Combine

protocol GithubCommitService {
    func getAllCommits(username: String, repository: String, page: Int, pageSize: Int) -> AnyPublisher<[GithubCommit], Error>
    func getCommitsForBranch(username: String, repository: String, branch: String, page: Int, pageSize: Int) -> AnyPublisher<[GithubCommit], Error>
    func getBranches(username: String, repository: String, page: Int, pageSize: Int) -> AnyPublisher<[GithubBranch], Error>

}
