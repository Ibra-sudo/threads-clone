//
//  FeedView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView (showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.threads) { thread in
                        ThreadCell(thread: thread)
                    }
                }
            }
            .refreshable {
                Task { try await viewModel.fetchThreads() }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(colorScheme == .light ? "threads-app-icon" : "threads-app-icon-white")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task { try await viewModel.fetchThreads() }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
