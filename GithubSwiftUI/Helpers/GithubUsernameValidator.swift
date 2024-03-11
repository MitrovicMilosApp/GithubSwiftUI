//
//  GithubUsernameValidator.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct GithubUsernameValidator {
    static func isValidUsername(_ username: String) -> Bool {
        let regex = "^(?!-)(?!.*--)[A-Za-z0-9-]{1,39}(?<!-)$"
        return username.range(of: regex, options: .regularExpression) != nil
    }
}
