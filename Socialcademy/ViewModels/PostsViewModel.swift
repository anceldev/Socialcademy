//
//  PostsViewModel.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import Foundation
import Observation

@Observable
class PostsViewModel {
    var posts = [Post.testPost]
    
    func makeCreateAction() -> NewPostForm.CreateAction {
        return { [weak self] post in
            try await PostsRepository.create(post)
            self?.posts.insert(post, at: 0)
        }
    }
}

