//
//  SearchPresenter.swift
//  Effem
//
//  Created by Thomas Rademaker on 5/19/23.
//

import SwiftUI

@MainActor
struct SearchPresenter: View {
    @Environment(SearchState.self) private var state: SearchState
    
    var body: some View {
        @Bindable var state = state
        
        NavigationStack {
            SearchView()
                .sheet(item: $state.sheet) {
                    switch $0 {
                    case .nostrInfo:
                        Text("NOSTR INFO")
                            .presentationDragIndicator(.visible)
                            .presentationDetents([.medium])
                    }
                }
        }
    }
}

@MainActor
struct SearchView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
    ]
    
    enum Scope: Int, CaseIterable, Identifiable {
        case all
        case title
        case person
        case term
        
        var id: Int { rawValue }
        
        var text: LocalizedStringResource {
            switch self {
            case .all: "all"
            case .title: "title"
            case .person: "person"
            case .term: "term"
            }
        }
    }
    
    @Environment(SearchState.self) private var state: SearchState
    @State private var query = ""
    @State private var scope: Int = Scope.all.rawValue
    @State private var performSearchTrigger = PlainTaskTrigger()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
//                ForEach(state.podcasts) {
//                    SearchListCell(podcast: $0)
//                }
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
        .padding(.bottom)
        .searchable(text: $query, prompt: "shows, episidoes, and more")
        .searchScopes($scope, activation: .onSearchPresentation) {
            ForEach(Scope.allCases) {
                Text($0.text).tag($0.rawValue)
            }
        }
        .onChange(of: query, triggerPerformSearch)
        .onChange(of: scope, triggerPerformSearch)
        .commonView()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("", systemImage: "questionmark.circle", action: displayPodcastIndexInfo)
            }
        }
        .navBar()
        .navigationTitle("Search")
        .task($performSearchTrigger) { await performSearch() }
    }
    
    private func triggerPerformSearch() {
        performSearchTrigger.trigger()
    }
    
    private func performSearch() async {
        guard query.count >= 3, let scope = Scope(rawValue: scope) else { return }
        
        switch scope {
        case .all:
            break
        case .title:
            break
        case .person:
            break
        case .term:
            break
        }
    }
    
    private func displayPodcastIndexInfo() {
        state.sheet = .nostrInfo
    }
}

#Preview {
    NavigationStack {
        SearchPresenter()
            .environment(SearchState(parentState: .init()))
            .environment(MediaPlaybackManager.shared)
            .environment(AppState())
    }
}
