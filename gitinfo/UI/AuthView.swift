//
//  AuthView.swift
//  gitinfo
//
//  Created by Anton on 10/6/22.
//

import SwiftUI
import BetterSafariView

struct AuthView: View
{
    @EnvironmentObject var modelView: GitinfoModelView
    @State private var startWebAuth = false
    @State private var loginState = "Login"
        
    var body: some View
    {
        if !modelView.authorized
        {
            Button(action: {
                self.startWebAuth = true
                self.loginState = "Logging ..."
            })
            {
                Text(loginState)
            }
            .webAuthenticationSession(isPresented: $startWebAuth)
            {
                WebAuthenticationSession(
                    url: URL(string: modelView.auth.baseUrl + modelView.auth.oauthUrl + "\(modelView.auth.clientId)")!,
                    callbackURLScheme: modelView.auth.schemeUrl
                )
                {
                    callbackURL, error in
                    
                    Task
                    {
                        if let url = callbackURL
                        {
                            await modelView.authorization(url: url)
                        }
                        else
                        {
                            self.loginState = "Login"
                        }
                    }
                }
                .prefersEphemeralWebBrowserSession(false)
            }
        }
        else
        {
            UserView(userInfo: modelView.userOwnInfo)
                .task
                {
                    await modelView.loadOwnUserInfo()
                }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
