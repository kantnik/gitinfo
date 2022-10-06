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

struct UserInfo: UserGithub
{
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
