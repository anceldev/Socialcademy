//
//  MainTabView.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            PostsList()
                .tabItem { Label("Posts", systemImage: "list.dash") }
            PostsList(viewModel: PostsViewModel(filter: .favorites))
                .tabItem { Label("Favorites", systemImage: "heart") }
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

#Preview {
    MainTabView()
}
