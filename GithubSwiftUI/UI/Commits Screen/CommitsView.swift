//
//  CommitsView.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import SwiftUI

struct CommitsView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var viewModel: CommitsViewModel
    
    init(viewModel: CommitsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Picker("Preview Mode", selection: $viewModel.previewMode) {
                Text("All Commits").tag(CommitsViewModel.PreviewMode.allCommits)
                Text("Branches").tag(CommitsViewModel.PreviewMode.branches)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            switch viewModel.previewMode {
            case .allCommits:
                List(viewModel.commits, id: \.id) { commit in
                    Text(commit.message ?? "No Message")
                }
                .navigationTitle("All commits")

            case .commitsForBranch(let branch):
                List(viewModel.commits, id: \.id) { commit in
                    Text(commit.message ?? "No Message")
                }
                .navigationTitle("Commits for \(branch)")
                
            case .branches:
                List(viewModel.branches, id: \.name) { branch in
                    Button(branch.name) {
                        viewModel.previewMode = .commitsForBranch(branch: branch.name)
                    }
                }
                .navigationTitle("Select branch")
            }
        }
    }
}
