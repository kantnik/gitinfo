//
//  TopBar.swift
//  gitinfo
//
//  Created by Anton on 10/6/22.
//

import SwiftUI

struct TopBar: View
{
    var body: some View
    {
        HStack
        {
            NavigationLink(destination: AuthView().navigationBarTitle("Auth", displayMode: .inline))
            {
                Image(systemName: "person.badge.key")
                    .imageScale(.medium)
                    .foregroundColor(.gray)
                    .padding(6)
            }
        }
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
