//
//  UrlReader.swift
//  gitinfo
//
//  Created by Anton on 10/6/22.
//

import Foundation

struct DataLoader
{
    let baseUrl = "https://api.github.com/"
    let userSearchUrl = "search/users?q="
    let session = URLSession.shared
    
    func loadUsers(userName: String) async throws -> [UserInfo]
    {
        guard let url = URL(string: baseUrl + userSearchUrl + "\(userName.trimmingCharacters(in: .whitespacesAndNewlines))") else
        {
            throw LoaderErrors.invalidURL
        }
                
        let (data, _) = try await session.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(UsersInfo.self, from: data).items
    }
    
    func loadRepos(userInfo: inout [UserInfo]) async throws
    {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        for i in 0 ..< userInfo.count
        {
            let (data, _) = try await session.data(from: userInfo[i].followersUrl)
            let reposInfo = try JSONDecoder().decode([FollowerInfo].self, from: data)
            
            userInfo[i].folovers = reposInfo.count
        }
    }
}
