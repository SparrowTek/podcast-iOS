//
//  LivePresenter.swift
//  Effem
//
//  Created by Thomas Rademaker on 4/17/24.
//

import SwiftUI

struct LivePresenter: View {
    var body: some View {
        NavigationStack {
            LiveView()
        }
    }
}

fileprivate struct LiveView: View {
    var body: some View {
        Text("Live")
    }
}

#Preview {
    LivePresenter()
}
