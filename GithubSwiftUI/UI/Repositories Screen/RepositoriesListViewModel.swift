//
//  RepositoriesListViewModel.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation
import Combine

class RepositoriesListViewModel: ObservableObject {
    
    // Input
    @Published var page: Int = 1
    
    // Output
    @Published var repositories: [GithubRepository] = []
    @Published var showLoader = false
    let user: GithubUser
    
    // Private
    private var pageSize = 100
    private var repositoriesService: GithubRepositoriesService
    private var cancellables = Set<AnyCancellable>()
    
    init(user: GithubUser, repositoriesService: GithubRepositoriesService) {
        self.repositoriesService = repositoriesService
        self.user = user
    }
    
    deinit {
        print("RepositoriesListViewModel deinit")
    }
    
    func getRepositories() {
        showLoader = true
        repositoriesService.getRepositories(username: user.username, page: page, pageSize: pageSize)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("getRepositories error \(error.localizedDescription)")
                    self.page = 1
                    self.repositories = []
                }
                self.showLoader = false
            } receiveValue: { [weak self] repositories in
                guard let self = self else { return }
                self.repositories.append(contentsOf: repositories)
                self.page += 1
                self.showLoader = false
            }
            .store(in: &cancellables)
    }
}
