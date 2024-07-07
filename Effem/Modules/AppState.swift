//
//  AppState.swift
//  Effem
//
//  Created by Thomas Rademaker on 5/19/23.
//

import Foundation
import SwiftData

@Observable
public class AppState {
    enum Route {
        case main
    }
    
    enum Tab {
        case home
        case live
        case library
        case search
    }
    
    enum Sheet: Int, Identifiable {
        case nowPlaying
        case settings
        case downloads
        
        var id: Int {
            self.rawValue
        }
    }

    var route: Route = .main
    var tab: Tab = .library
    var sheet: Sheet? = nil
    
    var downloadInProgress = true
    
    public init() {}
    
    @ObservationIgnored
    lazy var searchState = SearchState(parentState: self)
    @ObservationIgnored
    lazy var libraryState = LibraryState(parentState: self)
    @ObservationIgnored
    lazy var settingsState = SettingsState(parentState: self)
    @ObservationIgnored
    lazy var homeState = HomeState(parentState: self)
    @ObservationIgnored
    lazy var liveState = LiveState(parentState: self)
    
    func openSettings() {
        sheet = .settings
    }
    
    func openDownloads() {
        sheet = .downloads
    }
    
    func addItem() {
        
    }
    
    func openNowPlaying() {
        sheet = .nowPlaying
    }
}
