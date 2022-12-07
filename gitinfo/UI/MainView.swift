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
    
    var body: some View
    {
        NavigationView
        {
            VStack(spacing: 0)
            {
                TextField("Enter Name", text: $modelView.searchName, onCommit: {
                    Task
                    {
                        await self.modelView.searchUserInfo()
                    }
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color("darkGlossyGray"))
                    .padding(2)
                    .cornerRadius(12.0)
     
                UserList().navigationBarTitle("Gitinfo", displayMode: .inline)
                    .navigationBarTitle("Gitinfo", displayMode: .inline)
                    .navigationBarItems(trailing: TopBar())
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(GitinfoModelView())
    }
}
