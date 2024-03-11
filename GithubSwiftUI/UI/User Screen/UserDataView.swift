//
//  UserDataView.swift
//  GithubSwiftUI
//
//  Created by Milos Mitrovic on 11.3.24..
//

import SwiftUI

struct UserDataView: View {
    struct Sizes {
        static let imageSize: Double = 200
    }
    let user: GithubUser
    var body: some View {
        VStack {
            if let urlString = user.avatar_url, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                    default:
                        Color.gray
                    }
                }
                .scaledToFit()
                .frame(width: Sizes.imageSize, height: Sizes.imageSize, alignment: .center)
                .clipShape(Circle())
                
            } else {
                Color.gray
                    .frame(width: Sizes.imageSize, height: Sizes.imageSize, alignment: .center)
                    .clipShape(Circle())
            }
            
            Text(user.name ?? user.username)
                .font(.largeTitle)
            if let company = user.company {
                Text(company)
            }
        }
    }
}

#Preview {
    UserDataView(user: GithubUser(dtoObject: GithubUserDTO(name: "Korisnik", company: "Firma", avatar_url: "https://hws.dev/paul.jpg", login: "Login", public_repos: 4)))
}
