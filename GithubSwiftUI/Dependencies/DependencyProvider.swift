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
    
}
