//
//  ReplayThreadCell.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 21.07.24.
//

import SwiftUI
import Firebase

struct ReplayThreadCell: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    let thread: Thread
    
    @StateObject var viewModel = ComponentsViewModel()
    @State private var likeToggle: Bool = false
    @State private var caption = ""
    @State private var showCommentThreadView = false
    
    // to resizable height of a Rectangle
    private func calculateHeight() -> CGFloat {
        let textHeight = thread.caption.height(withConstrainedWidth: UIScreen.main.bounds.width - 60, font: UIFont.systemFont(ofSize: 14))
        return textHeight + 10
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                VStack {
                    
                    CircularProfileImageView(user: thread.user, size: .small)
                    
                    Rectangle()
                        .frame(width: 1.6, height: calculateHeight())
                        .foregroundColor(Color(.systemGray4))
                        .padding(.vertical, 4)
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
                }
            }
        }
    }
}
struct ReplayThreadCell_Previews: PreviewProvider {
    static var previews: some View {
        ReplayThreadCell(thread: dev.thread)
    }
}
