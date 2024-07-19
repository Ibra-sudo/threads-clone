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
    
    let thread: Thread
    
    @StateObject var viewModel = ComponentsViewModel()
    
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
                    
                    HStack(spacing: 16) {
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                                .resizable()
//                                .foregroundColor(.primary)
                                .modifier(ThreadCellModifier())
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.right")
                                .resizable()
//                                .foregroundColor(.primary)
                                .modifier(ThreadCellModifier())
                                .padding(.top, 2)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.rectanglepath")
//                                .foregroundColor(.primary)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane")
//                                .foregroundColor(.primary)
                        }
                    }
                    .foregroundColor(.primary)
                    .padding(.vertical, 6)
                }
            }
            
            Divider()
        }
        .padding()
    }
}

struct ThreadCell_Previews: PreviewProvider {
    static var previews: some View {
        ThreadCell(thread: dev.thread)
    }
}
