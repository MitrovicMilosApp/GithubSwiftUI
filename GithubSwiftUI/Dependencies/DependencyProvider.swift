//
//  DependencyProvider.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct DependencyProvider {
    private let client = URLSession.shared
    
    func userViewModel() -> UserViewModel {
        UserViewModel(userService: GithubUserAPIService(client: client))
    }
    
    func repositoriesListViewModel(user: GithubUser) -> RepositoriesListViewModel {
        RepositoriesListViewModel(user: user, repositoriesService: GithubRepositoriesAPIService(client: client))
    }
    
    func commitsViewModel(user: GithubUser, repository: GithubRepository) -> CommitsViewModel {
        CommitsViewModel(user: user, repository: repository, commitService: GithubCommitAPIService(client: client))
    }
    
}
