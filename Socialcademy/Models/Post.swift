//
//  Post.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import Foundation
import FirebaseFirestore

struct Post: Identifiable, Equatable {
    //    @DocumentID var id: String?
    var id = UUID()
    var title: String
    var content: String
    var author: User
    var timestamp = Date()
    var isFavorite = false
    var imageURL: URL?
    
    func contains(_ string: String) -> Bool {
        let properties = [title, content, author.name].map { $0.lowercased()}
        let query = string.lowercased()
        let matches = properties.filter { $0.contains(query) }
        return !matches.isEmpty
    }
}

extension Post {
    static let testPost = Post(
        title: "Lorem ipsum",
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        author: User.testUser)
}
extension Post: Codable {
    enum CodingKeys: CodingKey {
        case title, content, author, timestamp, id, imageURL
    }
}
