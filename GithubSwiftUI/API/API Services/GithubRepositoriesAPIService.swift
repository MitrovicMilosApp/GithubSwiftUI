//
//  GithubRepositoriesAPIService.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Combine

class GithubRepositoriesAPIService: GithubRepositoriesService {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getRepositories(username: String, page: Int, pageSize: Int) -> AnyPublisher<[GithubRepository], Error> {
        let path = GithubAPIPathProvider.UserData.repos(forUser: username, page: page, pageSize: pageSize)
        let request = GithubRequestProvider.makeRequest(path: path, method: .get)
        
        return client.publisher(request: request)
            .tryMap(GithubResponseMapper.mapRepositories)
            .map({ $0.map({ GithubRepository(dtoObject: $0)}) })
            .eraseToAnyPublisher()
    }
}
