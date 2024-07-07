//
//  EffemApp.swift
//  Effem
//
//  Created by Thomas Rademaker on 5/8/23.
//

import SwiftUI

@main
@MainActor
struct EffemApp: App {
    @State private var state = AppState()
    @State private var mediaPlaybackManager = MediaPlaybackManager.shared
    
    var body: some Scene {
        WindowGroup {
            AppPresenter()
                .environment(state)
                .environment(mediaPlaybackManager)
//                .setupModel()
                .setTheme()
        }
    }
}
