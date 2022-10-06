//
//  UserList.swift
//  gitinfo
//
//  Created by Anton on 10/5/22.
//

import SwiftUI

struct UserList: View
{
    @EnvironmentObject var modelView: GitinfoModelView
    
    var body: some View
    {
        ScrollView(.vertical)
        {
            LazyVStack(spacing: 0)
            {
                ForEach(0 ..< modelView.listUserInfo.count, id: \.self)
                {
                    UserItem(userInfo: modelView.listUserInfo[$0])
                }
            }
        }
    }
}

struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList()
    }
}
