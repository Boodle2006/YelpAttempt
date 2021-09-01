//
//  YelpAPIAppApp.swift
//  YelpAPIApp
//
//  Created by James Goldston on 9/1/21.
//

import SwiftUI

@main
struct YelpAPIApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView().environmentObject(contentModel())
        }
    }
}
