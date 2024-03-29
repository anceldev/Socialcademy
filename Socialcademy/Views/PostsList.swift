//
//  PostsList.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import SwiftUI

struct PostsList: View {
    @StateObject var viewModel: PostsViewModel
    
    @State var searchText = ""
    @State private var showNewPostForm = false
    
    
    var body: some View {
        
        Group {
            switch viewModel.posts {
            case .loading:
                ProgressView()
            case let .error(error):
                EmptyListView(
                    title: "Cannot Load Posts",
                    message: error.localizedDescription,
                    retryAction: { viewModel.fetchPosts() }
                )
            case .empty:
                EmptyListView(
                    title: "No Posts",
                    message: "There aren't any posts yet."
                )
            case let .loaded(posts):
                ScrollView {
                    ForEach(posts) { post in
                        if searchText.isEmpty || post.contains(searchText) {
                            PostRow(viewModel: viewModel.makePostRowViewModel(for: post))
                        }
                    }
                    .animation(.default, value: posts)
                    .searchable(text: $searchText)
                }
            }
        }
        .navigationTitle(viewModel.title)
        .toolbar {
            Button {
                showNewPostForm = true
            } label: {
                Label("New Post", systemImage: "square.and.pencil")
            }
        }
        .sheet(isPresented: $showNewPostForm, content: {
            NewPostForm(viewModel: viewModel.makeNewPostViewModel())
        })
        .onAppear {
            viewModel.fetchPosts()
        }
        
    }
    
}


#if DEBUG
@MainActor
private struct ListPreview: View {
    let state: Loadable<[Post]>
    
    var body: some View {
        let postsRepository = PostsRepositoryStub(state: state)
        let viewModel = PostsViewModel(postsRepository: postsRepository)
        NavigationStack {
            PostsList(viewModel: viewModel)
        }
    }
}

#Preview {
    ListPreview(state: .loaded([Post.testPost]))
}
#Preview {
    ListPreview(state: .empty)
}
#Preview {
    ListPreview(state: .error)
}
#Preview {
    ListPreview(state: .loading)
}
#endif
