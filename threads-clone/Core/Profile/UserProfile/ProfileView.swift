//
//  ProfileView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let user: User
    let comment: Comment
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            
            VStack(spacing: 20) {
                
                ProfileHeaderView(user: user)
                
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        .frame(width: 352, height: 32)
                        .background(colorScheme == .dark ? Color.white : Color.black)
                        .cornerRadius(8)
                }
                
                UserContentListView(user: user, comment: comment)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        
    }
}

//#Preview {
//    ProfileView(user: User(id: NSUUID().uuidString, fullname: "Max Moro", email: "max@gmail.com", username: "maxmoro1", bio: ""))
//}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user, comment: dev.comment)
    }
}
