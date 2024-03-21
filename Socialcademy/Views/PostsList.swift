//
//  PostsList.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import SwiftUI

struct PostsList: View {
    var viewModel = PostsViewModel()

    @State var searchText = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                if(searchText.isEmpty || post.contains(searchText)) {
                    PostRow(post: post)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Posts")
            .toolbar {
                Button {
                    showNewPostForm = true
                } label: {
                    Label("New Post", systemImage: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showNewPostForm, content: {
            NewPostForm(createAction: viewModel.makeCreateAction())
        })
    }
    
}

#Preview {
    PostsList()
}
