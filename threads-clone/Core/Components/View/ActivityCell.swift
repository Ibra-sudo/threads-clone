//
//  ActivityCell.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 16.07.24.
//

import SwiftUI

struct ActivityCell: View {
    
    let user: User
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    CircularProfileImageView(user: user, size: .medium)
                    
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        .background(.blue)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(colorScheme == .dark ? Color.black : Color.white , lineWidth: 2)
                        }
                        .offset(x: 20, y: 16)
                }
                .padding(.trailing, 10)
                    
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(user.username)
                            .fontWeight(.semibold)
                        Text("5d")
                            .foregroundColor(.gray)
                    }

                    Text("Followed you")
                        .foregroundColor(.gray)
                }
                .font(.footnote)
                
                Spacer()
                
                Text("Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 32)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
            }
            .padding(.horizontal)
            Divider()
                .padding(.leading, 80)
        }
        .padding(.vertical, 10)
    }
}

struct ActivityCell_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCell(user: dev.user)
    }
}
