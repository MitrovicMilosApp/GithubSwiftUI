//
//  GithubBranch.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct GithubBranch: Codable {
    let name: String
    init(dtoObject: GithubBranchDTO) {
        self.name = dtoObject.name
    }
}
