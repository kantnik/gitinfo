//
//  gitinfoApp.swift
//  gitinfo
//
//  Created by Anton on 10/4/22.
//

import SwiftUI

@main
struct gitinfoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(GitinfoModelView())
        }
    }
}
