//
//  LiveState.swift
//  Effem
//
//  Created by Thomas Rademaker on 4/17/24.
//

import Foundation

@Observable
class LiveState {
    private unowned let parentState: AppState
    
    init(parentState: AppState) {
        self.parentState = parentState
    }
}
