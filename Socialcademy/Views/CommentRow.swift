//
//  CommentRow.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 22/3/24.
//

import SwiftUI

struct CommentRow: View {
    //    let comment: Comment
    @ObservedObject var viewModel: CommentRowViewModel
    @State private var showConfirmationDialog = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, content: {
                Text(viewModel.auhor.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(viewModel.timestamp.formatted())
                    .foregroundStyle(.gray)
                    .font(.caption)
            })
            Text(viewModel.content)
                .font(.headline)
                .fontWeight(.regular)
        }
        .padding(5)
        .confirmationDialog("Are you sure you want to delete this comment?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
            Button("Delete", role: .destructive, action: {
                viewModel.deleteComment()
            })
        }
        .swipeActions {
            if viewModel.canDeleteComment {
                Button(role: .none) {
                    showConfirmationDialog = true
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .alert("Cannot Delete Comment", error: $viewModel.error)
        
        
    }
}

#Preview {
    CommentRow(viewModel: CommentRowViewModel(comment: Comment.testComment, deleteAction: {}))
        .previewLayout(.sizeThatFits)
}
