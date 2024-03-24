//
//  FormViewModel.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 22/3/24.
//

import Foundation

@MainActor
@dynamicMemberLookup
class FormViewModel<Value>: ObservableObject, StateManager {
    typealias Action = (Value) async throws -> Void
    private let action: Action
    
    @Published var value: Value
    @Published var error: Error?
    @Published var isWorking = false
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> T {
        get { value[keyPath: keyPath] }
        set { value[keyPath: keyPath] = newValue }
    }
    init(initialValue: Value, action: @escaping Action) {
        self.value = initialValue
        self.action = action
    }
    
    nonisolated func submit() {
        withStateManagingTask { [self] in
            try await action(value)
        }
    }
    
    private func handleSubmit() async {
        self.isWorking = true
        do {
            try await action(value)
        } catch {
            print("[FormViewModel] Cannot submit: \(error)")
            self.error = error
        }
        self.isWorking = false
    }
}
