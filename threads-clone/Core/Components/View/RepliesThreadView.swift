//
//  RepliesThreadView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 22.07.24.
//

import SwiftUI
import Firebase

struct RepliesThreadView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    let thread: Thread
//    let comment: Comment
    
    @StateObject var viewModel = ComponentsViewModel()
    @State private var caption = ""
    @State private var likeToggle: Bool = false
    @State private var showCommentThreadView = false
    
    private func calculateHeight() -> CGFloat {
        let textHeight = thread.caption.height(withConstrainedWidth: UIScreen.main.bounds.width - 60, font: UIFont.systemFont(ofSize: 14))
        return textHeight + 10
    }
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    var body: some View {
//        NavigationStack {
//            VStack {
//                List {
//                    ForEach(viewModel.threads) { thread in
//                        VStack(alignment: .leading, spacing: 8){
//                            HStack(alignment: .top, spacing: 12) {
//                                VStack {
//                                    CircularProfileImageView(user: thread.user, size: .small)
//                                    Rectangle()
//                                        .frame(width: 1.6, height: calculateHeight())
//                                        .foregroundColor(Color(.systemGray4))
//                                        .padding(.vertical, 3)
//                                }
//                                VStack(alignment: .leading, spacing: 2) {
//                                    HStack {
//                                        Text(thread.user?.username ?? "")
//                                            .font(.footnote)
//                                            .fontWeight(.semibold)
//                                        Spacer()
//                                        Text(thread.timestamp.timestampString())
//                                            .font(.caption)
//                                            .foregroundColor(colorScheme == .light ? Color(.systemGray3) : Color(.systemGray))
//                                        
//                                        Button {
//                                            Task { try await viewModel.deleteThread(thread: thread) }
//                                        } label: {
//                                            Image(systemName: "ellipsis")
//                                                .foregroundColor(colorScheme == .light ? Color(.darkGray) : Color.white)
//                                        }
//                                    }
//                                    
//                                    Text(thread.caption)
//                                        .font(.footnote)
//                                        .multilineTextAlignment(.leading)
//                                    
//                                    HStack(spacing: 16) {
//                                        Button {
//                                            Task {
//                                                if likeToggle {
//                                                    try await viewModel.unlikeThread(thread: thread)
//                                                } else {
//                                                    try await viewModel.likeThread(thread: thread)
//                                                }
//                                                //                                try await viewModel.toggleLike(thread: thread)
//                                                likeToggle.toggle()
//                                            }
//                                        } label: {
//                                            Image(systemName: likeToggle ? "heart.fill" : "heart")
//                                                .resizable()
//                                                .modifier(ThreadCellModifier())
//                                                .foregroundColor(likeToggle ? .red : (colorScheme == .dark ? .white : .black))
//                                        }
//                                        
//                                        Button {
//                                            showCommentThreadView.toggle()
//                                        } label: {
//                                            Image(systemName: "bubble.right")
//                                                .resizable()
//                                                .modifier(ThreadCellModifier())
//                                                .padding(.top, 2)
//                                        }
//                                        
//                                        Button {
//                                            
//                                        } label: {
//                                            Image(systemName: "arrow.rectanglepath")
//                                        }
//                                        
//                                        Button {
//                                            
//                                        } label: {
//                                            Image(systemName: "paperplane")
//                                        }
//                                    }
//                                    .foregroundColor(.primary)
//                                    .padding(.vertical, 6)
//                                }
//                            }
//                            
//                            ForEach(viewModel.comments) { comment in
//                                
//                            }
//                        }
//                    }
//                }
//            }
//            .onAppear {
//                likeToggle = thread.likes.contains(Auth.auth().currentUser?.uid ?? "")
//                Task { try await viewModel.fetchThreadsWithUserComments() }
//            }
//        }
//    -----------------------------------------------------------------------
        VStack {
            HStack(alignment: .top, spacing: 12) {
                VStack {
                    CircularProfileImageView(user: thread.user, size: .small)
                    
                    Rectangle()
                        .frame(width: 1.6, height: calculateHeight())
                        .foregroundColor(Color(.systemGray4))
                        .padding(.vertical, 3)
                }
                
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
                    
                    HStack(spacing: 16) {
                        Button {
                            Task {
                                if likeToggle {
                                    try await viewModel.unlikeThread(thread: thread)
                                } else {
                                    try await viewModel.likeThread(thread: thread)
                                }
                                //                                try await viewModel.toggleLike(thread: thread)
                                likeToggle.toggle()
                            }
                        } label: {
                            Image(systemName: likeToggle ? "heart.fill" : "heart")
                                .resizable()
                                .modifier(ThreadCellModifier())
                                .foregroundColor(likeToggle ? .red : (colorScheme == .dark ? .white : .black))
                        }
                        
                        Button {
                            showCommentThreadView.toggle()
                        } label: {
                            Image(systemName: "bubble.right")
                                .resizable()
                                .modifier(ThreadCellModifier())
                                .padding(.top, 2)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.rectanglepath")
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
            
//            ForEach(viewModel.comments) { comment in
                HStack(alignment: .top, spacing: 12) {
                    CircularProfileImageView(user: thread.user, size: .small)
                    VStack(alignment: .leading, spacing: 4) {
                        //                        Text(user?.username ?? "")
                        //                            .fontWeight(.semibold)
                        HStack {
                            Text(user?.username ?? "")
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(thread.timestamp.timestampString())
                                .font(.caption)
                                .foregroundColor(colorScheme == .light ? Color(.systemGray3) : Color(.systemGray))
                            
                            Button {
//                                Task { try await viewModel.deleteThread(thread: thread) }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(colorScheme == .light ? Color(.darkGray) : Color.white)
                            }
                        }
                        
                        Text(thread.caption)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                        
                        
                        HStack(spacing: 20) {
                            Button {
                                
                            } label: {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .resizable()
                                    .modifier(ThreadCreateModifier())
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "camera")
                                    .resizable()
                                    .modifier(ThreadCreateModifier())
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "text.bubble")
                                    .resizable()
                                    .modifier(ThreadCreateModifier())
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "mic")
                                    .resizable()
                                    .frame(width: 14, height: 18)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "number")
                                    .resizable()
                                    .modifier(ThreadCreateModifier())
                            }
                        }
                        .foregroundColor(.gray)
                        .padding(.top, 23)
                    }
                    .font(.footnote)
                }
//            }
            Divider()
                .padding(.top)
        }
        .padding()
        .onAppear {
            likeToggle = thread.likes.contains(Auth.auth().currentUser?.uid ?? "")
            Task { try await viewModel.fetchThreadsWithUserComments() }
        }
        .sheet(isPresented: $showCommentThreadView) {
            CommentThreadView(thread: thread)
        }
    }
}

struct RepliesThreadView_Previews: PreviewProvider {
    static var previews: some View {
        RepliesThreadView(thread: dev.thread)
    }
}
