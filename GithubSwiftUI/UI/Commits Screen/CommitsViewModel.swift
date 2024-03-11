//
//  CommitsViewModel.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation
import Combine

class CommitsViewModel: ObservableObject {
    
    enum PreviewMode: Hashable {
        case allCommits
        case commitsForBranch(branch: String)
        case branches
    }
    
    // Input

    @Published var page: Int = 0
    
    // Output

    @Published var branches: [GithubBranch] = []
    @Published var commits: [GithubCommit] = []
    @Published var previewMode = PreviewMode.allCommits

    private let pageSize = 100
    private let commitService: GithubCommitService
    private let user: GithubUser
    private let repository: GithubRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(user: GithubUser, repository: GithubRepository, commitService: GithubCommitService) {
        self.commitService = commitService
        self.user = user
        self.repository = repository
        
        $previewMode
            .receive(on: DispatchQueue.main)
            .sink { [weak self] mode in
                guard let self = self else { return }
                self.page = 0
                self.commits = []
                self.branches = []
                switch mode {
                case .allCommits:
                    self.getAllCommits()
                case .branches:
                    self.get100Branches()
                case .commitsForBranch(let branch):
                    self.getCommitsForBranch(branch)
                    
                }
            }
            .store(in: &cancellables)
    }
    
    deinit {
        print("CommitsViewModel deinit")
    }
    
    private func getAllCommits() {
        commitService.getAllCommits(username: user.username, repository: repository.name, page: page, pageSize: pageSize)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("getAllCommits error \(error.localizedDescription)")
                    self.page = 0
                    self.commits = []
                }
            } receiveValue: { [weak self] commits in
                guard let self = self else { return }
                self.commits.append(contentsOf: commits)
                self.page += 1
            }
            .store(in: &cancellables)
    }
    
    private func getCommitsForBranch(_ branch: String) {
        commitService.getCommitsForBranch(username: user.username, repository: repository.name, branch: branch, page: page, pageSize: pageSize)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("getCommitsForBranch error \(error.localizedDescription)")
                    self.page = 0
                    self.commits = []
                }
            } receiveValue: { [weak self] commits in
                guard let self = self else { return }
                self.commits.append(contentsOf: commits)
                self.page += 1
            }
            .store(in: &cancellables)

    }
    
    private func get100Branches() {
        commitService.getBranches(username: user.username, repository: repository.name, page: 0, pageSize: 100)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("get100Branches error \(error.localizedDescription)")
                    self.branches = []
                }
            } receiveValue: { [weak self] branches in
                guard let self = self else { return }
                self.branches.append(contentsOf: branches)
            }
            .store(in: &cancellables)
    }


}
