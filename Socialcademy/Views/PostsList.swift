//
//  PostsList.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import SwiftUI

struct PostsList: View {
    private var posts: [Post] = [Post.testPost]
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List(posts) { post in
                if(searchText.isEmpty || post.contains(searchText)) {
                    PostRow(post: post)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Posts")
        }
    }
    
}

#Preview {
    PostsList()
}
