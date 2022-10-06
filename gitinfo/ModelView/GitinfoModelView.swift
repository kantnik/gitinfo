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
                    
            if listUserInfo.count > 0
            {
                try await loader.loadRepos(userInfo: &listUserInfo)
            }
        }
        catch
        {
            print("Request faild: \(error)")
        }
    }
}
