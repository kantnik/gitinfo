//
//  GitinfoModelView.swift
//  gitinfo
//
//  Created by Anton on 10/4/22.
//

import Foundation
import SwiftUI

final class GitinfoModelView: ObservableObject
{
    @Published var authorized = false
    @Published var searchName = ""
    @Published var listUserInfo = [UserInfo]()
    @Published var listRepoInfo = [RepoInfo]()
    @Published var userOwnInfo = UserOwnInfo(id: 0, login: "", avatarUrl: nil, name: "", location: "", email: "", bio: "")
    
    private let loader: DataLoader
    private let loaderPrivate: PrivateDataLoader
    public let auth: AuthorizationGit
    
    init()
    {
        loader = DataLoader()
        loaderPrivate = PrivateDataLoader()
        auth = AuthorizationGit()
    }
    
    func clearRepoList()
    {
        listRepoInfo = [RepoInfo]()
    }
    
    @MainActor
    func searchUserInfo() async
    {
        do
        {
            listUserInfo = try await loader.loadUsers(userName: searchName)            
            listUserInfo = try await loader.updateCountUsersFollowers(userInfo: listUserInfo)
        }
        catch
        {
            print("Request faild: \(error)")
        }
    }

    @MainActor
    func loadRepoInfo(index: Int) async
    {
        do
        {
            listRepoInfo = try await loader.loadRepoInfo(userInfo: listUserInfo[index])
        }
        catch
        {
            print("Request faild: \(error)")
        }
    }
    
    @MainActor
    func loadOwnUserInfo() async
    {
        do
        {
            if let token = auth.getToken()
            {
                userOwnInfo = try await loaderPrivate.loadUserInfo(token: token)
            }
        }
        catch
        {
            print("Request faild: \(error)")
        }
    }

    @MainActor
    func authorization(url: URL) async
    {
        do
        {
            if let code = url.valueOf("code")
            {
                authorized = try await auth.loadAccessToken(code: code)
            }
        }
        catch
        {
            print("Authorization faild: \(error)")
        }
    }
}
