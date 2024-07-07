//
//  MainTabBar.swift
//  Effem
//
//  Created by Thomas Rademaker on 5/19/23.
//

import SwiftUI

@MainActor
struct MainTabBar: View {
    @Environment(AppState.self) private var state
    @Environment(MediaPlaybackManager.self) private var mediaPlaybackManager
    @State private var triggerSensoryFeedback = false
    
    var body: some View {
        @Bindable var state = state
        
        TabView(selection: $state.tab) {
            Group {
                HomePresenter()
                    .environment(state.homeState)
                    .tag(AppState.Tab.home)
                    .tabItem { Label("home", systemImage: "music.note.house") }
                
                LivePresenter()
                    .environment(state.liveState)
                    .tag(AppState.Tab.live)
                    .tabItem { Label("live", systemImage: "antenna.radiowaves.left.and.right") }
                
                LibraryPresenter()
                    .environment(state.libraryState)
                    .tag(AppState.Tab.library)
                    .tabItem { Label("library", systemImage: "music.quarternote.3")}
                
                SearchPresenter()
                    .environment(state.searchState)
                    .tag(AppState.Tab.search)
                    .tabItem { Label("search", systemImage: "magnifyingglass")}
            }
            .playbackBar()
//            .toolbarBackground(.visible, for: .tabBar)
//            .toolbarBackground(Color.primaryWhite, for: .tabBar)
        }
        .onChange(of: state.tab) { triggerSensoryFeedback.toggle() }
        .sensoryFeedback(.selection, trigger: triggerSensoryFeedback)
        .setTheme()
        .sheet(item: $state.sheet) {
            switch $0 {
            case .nowPlaying:
                NowPlayingView()
                    .setTheme()
            case .settings:
                SettingsPresenter()
                    .environment(state.settingsState)
                    .setTheme()
            case .downloads:
                Text("DOWNLOADS")
                    .presentationDragIndicator(.visible)
            }
        }
        
    }
}

#Preview {
    MainTabBar()
        .environment(AppState())
        .environment(MediaPlaybackManager.shared)
}
