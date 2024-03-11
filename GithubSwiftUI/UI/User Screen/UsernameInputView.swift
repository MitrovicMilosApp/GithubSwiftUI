//
//  UsernameInputView.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import SwiftUI

struct UsernameInputView: View {
    @ObservedObject var viewModel: UserViewModel
    var body: some View {
        Section {
            HStack(spacing: 10) {
                Text("/")
                    .font(.headline)
                TextField("username", text: $viewModel.username)
                    .textFieldStyle(.roundedBorder)
                    .font(.headline)
                
                Button("Visit") {
                    viewModel.getUser()
                }
                .disabled(!viewModel.isFormValid)
                .buttonStyle(.bordered)
                .frame(width: 100)
                
            }
            .padding(10)
        }
    }
}
