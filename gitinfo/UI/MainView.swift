//
//  MainView.swift
//  gitinfo
//
//  Created by Anton on 10/4/22.
//

import SwiftUI
import Combine

struct MainView: View
{
    @EnvironmentObject var modelView: GitinfoModelView
    @State var text = ""
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                TextField("Enter Name", text: $modelView.searchName, onCommit: {
                    Task
                    {
                        await self.modelView.searchUserInfo()
                    }
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
     
                UserList()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(GitinfoModelView())
    }
}
