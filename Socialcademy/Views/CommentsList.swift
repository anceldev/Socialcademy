//
//  CommentsList.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 22/3/24.
//

import SwiftUI

struct CommentsList: View {
    @StateObject var viewModel: CommentsViewModel
    
    var body: some View {
        NavigationView{
            Group {
                switch viewModel.comments {
                case .loading:
                    ProgressView()
                        .onAppear(perform: {
                            viewModel.fetchComments()
                        })
                case let .error(error):
                    EmptyListView(
                        title: "Cannot Load Comments",
                        message: error.localizedDescription,
                        retryAction: {
                            viewModel.fetchComments()
                        })
                case .empty:
                    EmptyListView(
                        title: "No Comments",
                        message: "Be the first to leave a comment")
                case let .loaded(comments):
                    List(comments) { comment in
                        CommentRow(viewModel: viewModel.makeCommentRowViewModel(for: comment))
                    }
                    .animation(.default, value: comments)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                
                    NewCommentForm(viewModel: viewModel.makeNewCommentViewModel())
                }
            }
        }
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension CommentsList {
    struct NewCommentForm: View {
        @StateObject var viewModel: FormViewModel<Comment>
        
        var body: some View {
            Group {
                TextField("Comment", text: $viewModel.content)
                Button(action: viewModel.submit, label: {
                    if viewModel.isWorking {
                        ProgressView()
                    } else {
                        Label("Post", systemImage: "paperplane")
                            .foregroundStyle(.red)
                    }
                })
            }
            .alert("Cannot Post Comment", error: $viewModel.error)
            .animation(.default, value: viewModel.isWorking)
            .disabled(viewModel.isWorking)
            .onSubmit(viewModel.submit)
        }
    }
}

#if DEBUG

private struct ListPreview: View {
    let state: Loadable<[Comment]>
    
    var body: some View {
        NavigationStack {
            CommentsList(viewModel: CommentsViewModel(commentsRepository: CommentsRepositoryStub(state: state)))
        }
    }
}
#Preview {
    ListPreview(state: .loaded([Comment.testComment]))
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
