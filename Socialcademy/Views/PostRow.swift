//
//  PostRow.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(post.authorName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text(post.timestamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
            }
            .foregroundStyle(.gray)
            Text(post.title)
                .font(.title3)
                .fontWeight(.semibold)
            Text(post.content)
        }
        .padding(.vertical)
    }
}

#Preview {
    PostRow(post: Post.testPost)
}
