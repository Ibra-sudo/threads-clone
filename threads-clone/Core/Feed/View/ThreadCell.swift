//
//  ThreadCell.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 10.07.24.
//

import SwiftUI

struct ThreadCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileImageView()
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("maxmoro")
                            .font(.footnote)
                        .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("10m")
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                    
                    Text("HR Management")
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

#Preview {
    ThreadCell()
}
