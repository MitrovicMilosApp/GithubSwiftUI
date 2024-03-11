//
//  UserScreen.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import SwiftUI

struct UserScreen: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var viewModel: UserViewModel
    
    var body: some View {
            VStack {
                UsernameInputView(viewModel: viewModel)
                if let user = viewModel.user {
                    UserDataView(user: user)
                    Button("Show repositories") {
                        coordinator.push(.repositories(user: user))
                    }
                    .buttonStyle(.bordered)
                    .frame(width: 200)
                } else if viewModel.shouldShowStartingMessage {
                    Text("Enter the username to perform search.")
                } else {
                    Text("User not found.")
                }
            }
            .padding()
    }
}

#Preview {
    UserScreen(viewModel: UserViewModel(userService: GithubUserAPIService(client: URLSession.shared)))
}


