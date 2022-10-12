//
//  PrivateDataLoader.swift
//  gitinfo
//
//  Created by Anton on 10/12/22.
//

import Foundation

struct PrivateDataLoader
{
    let baseUrl = "https://api.github.com/"
    let userUrl = "user"
    let session = URLSession.shared
  
    func loadUserInfo(token: AccessToken) async throws -> UserOwnInfo
    {
        guard let url = URL(string: baseUrl + userUrl) else
        {
            throw LoaderErrors.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await session.data(for: request)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(UserOwnInfo.self, from: data)
    }
}
