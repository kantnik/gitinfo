//
//  RepoItem.swift
//  gitinfo
//
//  Created by Anton on 10/5/22.
//

import SwiftUI

struct RepoItem: View
{
    var repoInfo: RepoInfo
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            VStack(alignment: .leading)
            {
                Text("Name: \(repoInfo.name)")
                    .font(.headline)
                    .lineLimit(1)
                Text("Desription: \(repoInfo.description ?? "")")
                    .font(.subheadline)
                    .lineLimit(2)
                Text("Updated: \(repoInfo.updatedAt ?? "")")
                    .lineLimit(1)
                    .font(.subheadline)
            }

            HStack()
            {
                VStack(alignment: .leading)
                {
                    Text("Language: \(repoInfo.language ?? "")")
                        .font(.subheadline)
                    Text("Branch: \(repoInfo.defaultBranch ?? "")")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .leading)
                {
                    Text("Forks: \(repoInfo.forks ?? 0)")
                        .font(.subheadline)
                    Text("Stars: \(repoInfo.stargazersCount ?? 0)")
                        .font(.subheadline)
                }
            }
            .padding(4)
        }
        .padding()
        .background(Color("darkGlossyGray"))
        .padding(2)
        .cornerRadius(12.0)
    }
}

struct RepoItem_Previews: PreviewProvider {
    static var previews: some View {
        RepoItem(repoInfo: RepoInfo(name: "Name", description: "test", updatedAt: "2022.09.08", defaultBranch: "master", forks: 4, stargazersCount: 3, language: "Java"))
    }
}
