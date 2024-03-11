//
//  UserViewModel.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    
    // Input
    @Published var username: String = ""

    // Output
    @Published var isFormValid = false
    @Published var user: GithubUser?
    @Published var shouldShowStartingMessage = true
    
    private var userService: GithubUserService
    private var cancellables = Set<AnyCancellable>()
    
    init(userService: GithubUserService) {
        self.userService = userService
        isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
    }
    
    deinit {
        print("UserViewModel deinit")
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        $username
            .receive(on: DispatchQueue.main)
            .map { GithubUsernameValidator.isValidUsername($0) }
            .eraseToAnyPublisher()
    }
    
    func getUser() {
        guard isFormValid else { return }
        shouldShowStartingMessage = false
        userService.getUser(username)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    print("getUser finished")
                case .failure(let error):
                    print("getUser error \(error.localizedDescription)")
                    self.user = nil
                }
            } receiveValue: { [weak self] user in
                guard let self = self else { return }
                self.user = user
            }
            .store(in: &cancellables)
    }
}
