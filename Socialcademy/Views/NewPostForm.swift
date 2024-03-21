//
//  NewPostForm.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//

import SwiftUI
import OSLog



struct NewPostForm: View {
    typealias CreateAction = (Post) async throws -> Void
    let createAction: CreateAction

    @State private var post = Post(title: "", content: "", authorName: "")
    @Environment(\.dismiss) private var dismiss
    @State private var state = FormState.idle

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $post.title)
                    TextField("Autho name", text: $post.authorName)
                }
                Section("Content") {
                    TextEditor(text: $post.content)
                        .multilineTextAlignment(.leading)
                }
                Button(action: createPost, label: {
                    if state == .working {
                        ProgressView()
                    } else {
                        Text("Create Post")
                    }
                })
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .padding()
                .listRowBackground(Color.accentColor)
            }
            .onSubmit(createPost)
            .navigationTitle("New Post")
        }
        .disabled(state == .working)
        .alert("Cannot Create Post", isPresented: $state.isError, actions: {}) {
            Text("Sorry, something went wrong.")
        }
    }
    private func createPost() {
        Task {
            state = .working
            do {
                try await createAction(post)
                dismiss()
            }
            catch {
                print("[NewPostForm] Cannot create post: \(error)")
                state = .error
            }
        }
    }
}

#Preview {
    NewPostForm(createAction: { _ in })
}

private extension NewPostForm {
    enum FormState {
        case idle, working, error
        
        var isError: Bool {
            get {
                self == .error
            }
            set {
                guard !newValue else { return }
                self = .idle
            }
        }
    }
}
