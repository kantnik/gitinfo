//
//  RepoList.swift
//  gitinfo
//
//  Created by Anton on 10/5/22.
//

import SwiftUI

struct RepoList: View
{
    @EnvironmentObject var modelView: GitinfoModelView
    var index: Int
    
    init(index: Int)
    {
        self.index = index
    }
    
    var body: some View
    {
        ScrollView(.vertical)
        {
            if modelView.listRepoInfo.count > 0
            {
                LazyVStack(spacing: 0)
                {
                    ForEach(0 ..< modelView.listRepoInfo.count, id: \.self)
                    {
                        RepoItem(repoInfo: modelView.listRepoInfo[$0])
                    }
                }
            }
            else
            {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .task
        {
            await self.modelView.loadRepoInfo(index: index)
        }
        .onDisappear()
        {
            modelView.clearRepoList()
        }
    }
}

struct RepoList_Previews: PreviewProvider {
    static var previews: some View {
        RepoList(index: 1)
    }
}
