//
//  Structures.swift
//  gitinfo
//
//  Created by Anton on 10/5/22.
//

import Foundation
import SwiftUI
import CoreLocation

protocol UserGithub: Hashable, Codable
{
    var login: String { get }
    var avatarUrl: URL { get }
    var followersUrl: URL { get }
    var reposUrl: URL { get }
}

struct UserInfo: UserGithub ,Identifiable//, Comparable
{
    var id: Int?
    let login: String
    let avatarUrl: URL
    let followersUrl: URL
    let reposUrl: URL
    var folovers: Int?
}

struct FollowerInfo: Hashable, Codable
{
    let id: Int
    let login: String
}

struct UsersInfo: Codable
{
    var items: [UserInfo]
}

enum LoaderErrors: Error
{
    case invalidURL
}


struct RepoInfo: Hashable, Codable
{
    let name: String
    let description: String?
    let updatedAt: String?
    let defaultBranch: String?
    let forks: Int?
    let stargazersCount: Int?
    let language: String?
}
