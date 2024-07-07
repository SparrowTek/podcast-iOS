//
//  AppPresenter.swift
//  Effem
//
//  Created by Thomas Rademaker on 5/19/23.
//

import SwiftUI
import SwiftData

@MainActor
struct AppPresenter: View {
    @Environment(AppState.self) private var state
    @Environment(\.modelContext) private var context
    
    var body: some View {
        switch state.route {
        case .main:
            MainTabBar()
        }
    }
}

#Preview {
    AppPresenter()
        .environment(AppState())
        .environment(MediaPlaybackManager.shared)
//    #if DEBUG
//        .modelContainer(previewContainer)
//    #endif
}
