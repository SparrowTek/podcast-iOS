//
//  HomePresenter.swift
//  Effem
//
//  Created by Thomas Rademaker on 4/17/24.
//

import SwiftUI

struct HomePresenter: View {
    var body: some View {
        NavigationStack {
            HomeView()
        }
    }
}

fileprivate struct HomeView: View {
    var body: some View {
        Text("Home")
    }
}

#Preview {
    HomePresenter()
}
