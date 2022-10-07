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
        
        var listUserInfo = try decoder.decode(UsersInfo.self, from: data).items
        
        for i in 0 ..< listUserInfo.count
        {
            listUserInfo[i].id = i
        }
        
        return listUserInfo
    }
    
    func updateCountUsersFollowers(userInfo: [UserInfo]) async throws -> [UserInfo]
    {
        try await withThrowingTaskGroup(of: UserInfo.self)
        {
            group in
            
            for item in userInfo
            {
                group.addTask
                {
                    try await updateCountUserFollowers(userInfo: item)
                }
            }
            
            let unsortedResult = try await group.reduce(into: [UserInfo]())
            {
                $0.append($1)
            }
            
            return unsortedResult.sorted { $0.id! < $1.id! }
        }
    }
    
    func updateCountUserFollowers(userInfo: UserInfo) async throws -> UserInfo
    {
        var userInfo = userInfo
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let (data, _) = try await session.data(from: userInfo.followersUrl)
        let followersInfo = try JSONDecoder().decode([FollowerInfo].self, from: data)
        
        userInfo.folovers = followersInfo.count
        
        return userInfo
    }
    
    func loadRepoInfo(userInfo: UserInfo) async throws -> [RepoInfo]
    {
        let (data, _) = try await session.data(from: userInfo.reposUrl)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode([RepoInfo].self, from: data)
    }
}
