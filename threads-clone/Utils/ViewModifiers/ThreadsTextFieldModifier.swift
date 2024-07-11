//
//  ThreadsTextFieldModifier.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI

struct ThreadsTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}

struct ThreadCellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 20, height: 18)
    }
}
