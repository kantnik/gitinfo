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
    @Published var searchName = ""
    @Published var listUserInfo = [UserInfo]()
    @Published var listRepoInfo = [RepoInfo]()
    
    private let loader: DataLoader
    
    init()
    {
        loader = DataLoader()
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
}
