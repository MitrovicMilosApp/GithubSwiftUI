//
//  GithubUserAPIService.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Combine

class GithubUserAPIService: GithubUserService {
    
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getUser(_ username: String) -> AnyPublisher<GithubUser?, Error> {
        let path = GithubAPIPathProvider.UserData.user(username)
        let request = GithubRequestProvider.makeRequest(path: path, method: .get)
        
        return client.publisher(request: request)
            .tryMap(GithubResponseMapper.mapUser)
            .map({ GithubUser(dtoObject: $0) })
            .eraseToAnyPublisher()
    }
}
