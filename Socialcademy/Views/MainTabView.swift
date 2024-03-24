//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var factory: ViewModelFactory
    var body: some View {
        TabView {
            NavigationStack {
                PostsList(viewModel: factory.makePostsViewModel())
            }
            .tabItem { Label("Posts", systemImage: "list.dash") }
            NavigationStack {
                PostsList(viewModel: factory.makePostsViewModel(filter: .favorites))
            }
            .tabItem { Label("Favorites", systemImage: "heart") }
            
            ProfileView(viewModel: factory.makeProfileViewModel())
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(ViewModelFactory.preview)
}
