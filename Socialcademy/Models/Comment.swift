//
//  Comment.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 22/3/24.
//

import Foundation

struct Comment: Identifiable, Equatable, Codable {
    var content: String
    var auhor: User
    var timestamp = Date()
    var id = UUID()
}

extension Comment {
    static let testComment = Comment(content: "Lorem upsum dolor set amet.", auhor: User.testUser)
}
