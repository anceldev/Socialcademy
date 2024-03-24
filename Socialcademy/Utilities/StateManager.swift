//
//  ErrorHandler.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 22/3/24.
//

import Foundation

@MainActor
protocol StateManager: AnyObject {
    var error: Error? { get set }
    var isWorking: Bool { get set }
}
extension StateManager {
    
    typealias Action = () async throws -> Void
    
    nonisolated func withStateManagingTask(perform action: @escaping () async throws -> Void) {
        Task {
            await withStateManagement(perfomr: action)
        }
    }
    private func withStateManagement(perfomr action: @escaping Action) async {
        isWorking = true
        do {
            try await action()
        } catch {
            print("[\(Self.self)] Error: \(error)")
            self.error = error
        }
        isWorking = false
    }
}
extension StateManager {
    var isWorking: Bool {
        get { false }
        set {}
    }
}
