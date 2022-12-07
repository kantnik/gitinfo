//
//  gitinfoApp.swift
//  gitinfo
//
//  Created by Anton on 10/4/22.
//

import SwiftUI

@main
struct gitinfoApp: App {
    @StateObject private var gitinfoModelView = GitinfoModelView()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(gitinfoModelView)
        }
    }
}
