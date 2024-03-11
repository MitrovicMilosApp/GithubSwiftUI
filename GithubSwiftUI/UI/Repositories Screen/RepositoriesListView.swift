//
//  RepositoriesListView.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import SwiftUI

struct RepositoriesListView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var viewModel: RepositoriesListViewModel
    
    init(viewModel: RepositoriesListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoader {
                ProgressView()
            } else {
                List(viewModel.repositories, id: \.name) { repository in
                    Button(repository.name) {
                        coordinator.push(.commits)
                    }
                }
                .navigationTitle("Repositories")
            }
        }
        .onAppear(perform: {
            viewModel.getRepositories()
        })
    }
    
}
