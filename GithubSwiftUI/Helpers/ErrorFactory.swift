//
//  ErrorFactory.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import Foundation

struct ErrorFactory {
    static func createWith(statusCode: Int) -> Error {
        let messageString: String = switch statusCode {
        case 400:
             "Bad Request"
        case 401:
             "Unauthenticated"
        case 403:
             "Forbidden"
        case 404:
             "Resource Not Found"
        case 500:
             "Server Error"
        default:
             "\(statusCode)"
        }
        return NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: messageString])
    }
    
    static func createWith(apiError: APIError) -> Error {
        apiError
    }
}
