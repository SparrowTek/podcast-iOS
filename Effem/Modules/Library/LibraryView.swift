//
//  LibraryView.swift
//  Effem
//
//  Created by Thomas Rademaker on 5/19/23.
//

import SwiftUI
import SwiftData
import NukeUI

struct LibraryPresenter: View {
    @Environment(LibraryState.self) private var state: LibraryState
    
    var body: some View {
        NavigationStack {
            LibraryView()
        }
    }
}

struct LibraryView: View {
    private var tabs: [UnderlinedTab] = [
        .init(id: 0, title: "episodes"),
        .init(id: 1, title: "shows"),
    ]
    
    var body: some View {
        VStack {
            UnderlinedTabView(tabs: tabs, tabViewStyle: .automatic) {
                LibraryEpisodesView()
                    .tag(0)
                
                LibraryShowsView()
                    .tag(1)
            }
        }
        .navBar()
        .commonView()
    }
}

fileprivate struct LibraryEpisodesView: View {
    @Query private var podcasts: [FMPodcast]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        List {
            ForEach(podcasts) {
                LibraryPodcastCell(podcast: $0)
            }
            .onDelete(perform: deletePodcast)
        }
        .listStyle(.plain)
        .commonView()
    }
    
    private func deletePodcast(_ indexSet: IndexSet) {
        for item in indexSet {
            let podcast = podcasts[item]
            modelContext.delete(podcast)
        }
    }
}

fileprivate struct LibraryShowsView: View {
    @Query private var podcasts: [FMPodcast]
    
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(podcasts) {
                    LibraryShowCell(podcast: $0)
                }
            }
            .foregroundStyle(.accent)
        }
        .scrollIndicators(.hidden)
        .commonView()
    }
}

fileprivate struct LibraryShowCell: View {
    var podcast: FMPodcast
    
    var imageURL: String? {
        if let artwork = podcast.artwork {
            return artwork
        } else {
            return podcast.image
        }
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                CommonImage(image: .url(url: imageURL, sfSymbol: "photo"))
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                Text("1")
                    .background(
                        Circle()
                            .fill(.green)
                    )
            }
            
            Text(podcast.title ?? "")
        }
    }
}

fileprivate struct LibraryPodcastCell: View {
    var podcast: FMPodcast
    
    var imageURL: String? {
        if let artwork = podcast.artwork {
            return artwork
        } else {
            return podcast.image
        }
    }
    
    var body: some View {
        HStack {
            CommonImage(image: .url(url: imageURL, sfSymbol: "photo"))
                .frame(width: 75, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            VStack(alignment: .leading) {
                Text(podcast.title ?? "")
                    .font(.title2)
                Text(podcast.author ?? "")
                    .font(.footnote)
                Spacer()
            }
            .padding(.top)
            
            Spacer()
            
            Circle()
                .fill(.green)
                .frame(width: 10)
        }
        .listRowBackground(Color.primaryBackground)
        .listRowSeparator(.hidden, edges: .top)
        
    }
}

#Preview {
    LibraryPresenter()
        .environment(AppState())
        .environment(LibraryState(parentState: .init()))
        .environment(MediaPlaybackManager.shared)
        #if DEBUG
        .modelContainer(previewContainer)
        #endif
}
