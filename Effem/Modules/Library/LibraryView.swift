//
//  LibraryView.swift
//  Effem
//
//  Created by Thomas Rademaker on 5/19/23.
//

import SwiftUI
import SwiftData
import NukeUI

@MainActor
struct LibraryPresenter: View {
    @Environment(LibraryState.self) private var state: LibraryState
    
    var body: some View {
        NavigationStack {
            LibraryView()
        }
    }
}

@MainActor
struct LibraryView: View {
    private var tabs: [UnderlinedTab] = [
        .init(id: 0, title: "episodes"),
        .init(id: 1, title: "shows"),
    ]
    
    var body: some View {
        VStack {
            UnderlinedTabView(tabs: tabs, tabViewStyle: .automatic) {
                Text("0")
                    .tag(0)
                
                Text("1")
                    .tag(1)
            }
        }
        .navBar()
        .commonView()
    }
}

#Preview {
    LibraryPresenter()
        .environment(AppState())
        .environment(LibraryState(parentState: .init()))
        .environment(MediaPlaybackManager.shared)
//        #if DEBUG
//        .modelContainer(previewContainer)
//        #endif
}
