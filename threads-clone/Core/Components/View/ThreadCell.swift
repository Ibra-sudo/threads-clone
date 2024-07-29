//
//  ThreadCell.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 10.07.24.
//

import SwiftUI
import Firebase

struct ThreadCell: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    let thread: Thread
    
    @StateObject var viewModel = ComponentsViewModel()
    @State private var likeToggle: Bool = false
    @State private var repostToggle: Bool = false
    @State private var showCommentThreadView = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileImageView(user: thread.user, size: .small)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(thread.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(thread.timestamp.timestampString())
                            .font(.caption)
                            .foregroundColor(colorScheme == .light ? Color(.systemGray3) : Color(.systemGray))
                        
                        Button {
                            Task { try await viewModel.deleteThread(thread: thread) }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(colorScheme == .light ? Color(.darkGray) : Color.white)
                        }
                    }
                    
                    Text(thread.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    
                    HStack(spacing: 12) {
                        Button {
                            Task {
                                if likeToggle {
                                    try await viewModel.unlikeThread(thread: thread)
                                } else {
                                    try await viewModel.likeThread(thread: thread)
                                }
                                likeToggle.toggle()
                            }
                        } label: {
                            Image(systemName: likeToggle ? "heart.fill" : "heart")
                                .resizable()
                                .modifier(ThreadCellModifier())
                                .foregroundColor(likeToggle ? .red : (colorScheme == .dark ? .white : .black))
                            if !thread.likes.isEmpty {
                                Text("\(formattedLikesCommentsCount(thread.likes.count))")
                                    .font(.footnote)
                                    .fontWeight(.light)
                            } else {
                                Text("\(thread.likes.count)")
                                    .font(.footnote)
                                    .fontWeight(.light)
                                    .opacity(0.0)
                            }
                        }
                        
                        Button {
                            showCommentThreadView.toggle()
                        } label: {
                            Image(systemName: "bubble.right")
                                .resizable()
                                .modifier(ThreadCellModifier())
                                .padding(.top, 2)
                            if !thread.comments.isEmpty {
                                Text("\(formattedLikesCommentsCount(thread.comments.count))")
                                    .font(.footnote)
                                    .fontWeight(.light)
                            } else {
                                Text("\(thread.comments.count)")
                                    .font(.footnote)
                                    .fontWeight(.light)
                                    .opacity(0.0)
                            }
                        }
                        
                        Button {
                            Task {
                                if repostToggle {
                                    try await viewModel.unrepostThread(thread: thread)
                                } else {
                                    try await viewModel.repostThread(thread: thread)
                                }
                                repostToggle.toggle()
                            }
                        } label: {
                            Image(systemName: "arrow.2.squarepath")
                            if !thread.repostedBy.isEmpty {
                                Text("\(formattedLikesCommentsCount(thread.repostedBy.count))")
                                    .font(.footnote)
                                    .fontWeight(.light)
                            } else {
                                Text("\(thread.repostedBy.count)")
                                    .font(.footnote)
                                    .fontWeight(.light)
                                    .opacity(0.0)
                            }
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane")
                        }
                    }
                    .foregroundColor(.primary)
                    .padding(.vertical, 6)
                }
            }
            
            Divider()
        }
        .padding()
        .onAppear {
//            likeToggle = thread.likes.contains(Auth.auth().currentUser?.uid ?? "")
//            Task { repostToggle = thread.repostedBy.contains(where: { $0 == thread.id}) }
        }
        .sheet(isPresented: $showCommentThreadView) {
            CommentThreadView(thread: thread)
        }
    }
}

func formattedLikesCommentsCount(_ count: Int) -> String {
    if count < 1000 {
        return "\(count)"
    } else if count < 1_000_000 {
        let formattedNumber = Double(count) / 1000.0
        return String(format: "%.1fk", formattedNumber)
    } else if count < 1_000_000_000 {
        let formattedNumber = Double(count) / 1_000_000.0
        return String(format: "%.1fM", formattedNumber)
    } else {
        let formattedNumber = Double(count) / 1_000_000_000.0
        return String(format: "%.1fB", formattedNumber)
    }
}

struct ThreadCell_Previews: PreviewProvider {
    static var previews: some View {
        ThreadCell(thread: dev.thread)
    }
}
