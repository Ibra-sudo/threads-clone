//
//  ThreadCell.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 10.07.24.
//

import SwiftUI
import Firebase

struct ThreadCell: View {
    
    let thread: Thread
    
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
                            .foregroundColor(Color(.systemGray3))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
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
                                .modifier(ThreadCellModifier())
                        }
                        
                        Button {
                            
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
                    .foregroundColor(.black)
                    .padding(.vertical, 6)
                }
            }
            
            Divider()
        }
        .padding()
    }
}

//#Preview {
//    ThreadCell(thread: Thread(ownerUid: "123", caption: "This is a test thread", timestamp: Timestamp(), likes: 0))
//}

struct ThreadCell_Previews: PreviewProvider {
    static var previews: some View {
        ThreadCell(thread: dev.thread)
    }
}
