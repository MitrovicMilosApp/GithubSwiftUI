//
//  GithubRepository.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct GithubRepository: Codable, Hashable {
    let name: String
    init(dtoObject: GithubRepositoryDTO) {
        self.name = dtoObject.name
    }
}
