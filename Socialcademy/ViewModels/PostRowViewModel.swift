//
//  PostRowViewModel.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import Foundation
import Observation

//@Observable
@MainActor
@dynamicMemberLookup
class PostRowViewModel: ObservableObject, StateManager {
    typealias Action = () async throws -> Void
    
    @Published var post: Post
    @Published var error: Error?
    
    private let deleteAction: Action?
    private let favoriteAction: Action
    var canDeletePost: Bool { deleteAction != nil }
    
    init(post: Post, deleteAction: Action?, favoriteAction: @escaping Action) {
        self.post = post
        self.deleteAction = deleteAction
        self.favoriteAction = favoriteAction
    }
    
    func deletePost() {
        guard let deleteAction = deleteAction else {
            preconditionFailure("Cannot delete post: no delete action provided")
        }
        withStateManagingTask(perform: deleteAction)
    }
    func favoritePost() {
        withStateManagingTask(perform: favoriteAction)
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<Post, T>) -> T {
        post[keyPath: keyPath]
    }
    
}
