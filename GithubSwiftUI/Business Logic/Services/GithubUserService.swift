//
//  GithubUserService.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Combine

protocol GithubUserService {
    func getUser(_ username: String) -> AnyPublisher<GithubUser?, Error>
}
