//
//  Alert+Error.swift
//  Socialcademy
//
//  Created by Ancel Dev account on 21/3/24.
//
import SwiftUI
import Foundation

private struct ErrorAlertViewModifier: ViewModifier {
    let title: String
    
    @Binding var error: Error?
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $error.hasValue, presenting: error, actions: { _ in }) { error in
                Text(error.localizedDescription)
            }
    }
}

extension View {
    func alert(_ title: String, error: Binding<Error?>) -> some View {
        modifier(ErrorAlertViewModifier(title: title, error: error))
    }
}

private extension Optional {
    var hasValue: Bool {
        get { self != nil }
        set { self = newValue ? self : nil }
    }
}
