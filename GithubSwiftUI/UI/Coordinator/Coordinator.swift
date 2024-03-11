//
//  Coordinator.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import SwiftUI

enum Page: Identifiable, Hashable {
    case user
    case repositories
    case commits
    
    var id: String {
        switch self {
        case .user:
            "user"
        case .repositories:
            "repositories"
        case .commits:
            "commits"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
// NOTE: Here we would add screens that are presented modally as separate enums

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    let dependencyProvider = DependencyProvider()
    
    func push(_ page: Page) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .user:
            Color.blue
        case .repositories:
            Color.red
        case .commits:
            Color.yellow
        }
    }

    // NOTE: Here we would handle modal presenting, keeping references to modally presented screens, and handling presenting and dismissing
    
}
