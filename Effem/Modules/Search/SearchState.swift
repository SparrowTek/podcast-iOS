//
//  SearchState.swift
//  Effem
//
//  Created by Thomas Rademaker on 5/19/23.
//

import Foundation
import SwiftData

@Observable
class SearchState {
    enum Sheet: Int, Identifiable {
        case nostrInfo
        
        var id: Int { rawValue }
    }
    
    private unowned let parentState: AppState
    var sheet: Sheet?
    
    init(parentState: AppState) {
        self.parentState = parentState
    }
}
