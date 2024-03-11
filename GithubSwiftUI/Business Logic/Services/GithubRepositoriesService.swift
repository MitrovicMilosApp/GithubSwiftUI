//
//  GithubRepositoriesService.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Combine

protocol GithubRepositoriesService {
    func getRepositories(username: String, page: Int, pageSize: Int) -> AnyPublisher<[GithubRepository], Error>
}
