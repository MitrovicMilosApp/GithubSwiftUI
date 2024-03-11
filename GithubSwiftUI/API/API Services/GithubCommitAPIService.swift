//
//  GithubCommitAPIService.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Combine

class GithubCommitAPIService: GithubCommitService {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getAllCommits(username: String, repository: String, page: Int, pageSize: Int) -> AnyPublisher<[GithubCommit], Error> {
        let path = GithubAPIPathProvider.RepositoryData.allCommits(forUser: username, repository: repository, page: page, pageSize: pageSize)
        let request = GithubRequestProvider.makeRequest(path: path, method: .get)
        
        return client.publisher(request: request)
            .tryMap(GithubResponseMapper.mapCommits)
            .map({ $0.map(({ GithubCommit(dtoObject: $0)})) })
            .eraseToAnyPublisher()
    }
    
    func getCommitsForBranch(username: String, repository: String, branch: String, page: Int, pageSize: Int) -> AnyPublisher<[GithubCommit], Error> {
        let path = GithubAPIPathProvider.RepositoryData.commitsForBranch(forUser: username, repository: repository, branch: branch, page: page, pageSize: pageSize)
        let request = GithubRequestProvider.makeRequest(path: path, method: .get)
        
        return client.publisher(request: request)
            .tryMap(GithubResponseMapper.mapCommits)
            .map({ $0.map(({ GithubCommit(dtoObject: $0)})) })
            .eraseToAnyPublisher()
    }
    
    func getBranches(username: String, repository: String, page: Int, pageSize: Int) -> AnyPublisher<[GithubBranch], Error> {
        let path = GithubAPIPathProvider.RepositoryData.branches(forUser: username, repository: repository, page: page, pageSize: pageSize)
        let request = GithubRequestProvider.makeRequest(path: path, method: .get)
        
        return client.publisher(request: request)
            .tryMap(GithubResponseMapper.mapBranches)
            .map({ $0.map({ GithubBranch(dtoObject: $0)}) })
            .eraseToAnyPublisher()
    }
}
