//
//  UserItem.swift
//  gitinfo
//
//  Created by Anton on 10/4/22.
//

import SwiftUI

struct UserItem: View
{
    var userInfo: UserInfo
    
    var body: some View
    {
        HStack
        {
            AsyncImage(url: userInfo.avatarUrl)
            {
                image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            placeholder:
            {
                Image(systemName: "person.crop.rectangle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(width: 48, height: 48)
            .clipShape(Circle())
            .shadow(radius: 6.0)
            .padding(12)
            
            VStack(alignment: .leading)
            {
                Text(userInfo.login)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("Followers: \(userInfo.folovers ?? 0)")
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer()
        }
        .background(Color("darkGlossyGray"))
        .padding(2)
        .cornerRadius(12.0)
    }
}

struct UserItem_Previews: PreviewProvider {
    static var previews: some View {
        UserItem(userInfo: UserInfo(login: "Anton", avatarUrl: Foundation.URL(string: "https://avatars.githubusercontent.com/u/914515?v=4")!, followersUrl: Foundation.URL(string: "https://avatars.githubusercontent.com/u/914515?v=4")!, reposUrl: Foundation.URL(string: "https://avatars.githubusercontent.com/u/914515?v=4")!))
    }
}
