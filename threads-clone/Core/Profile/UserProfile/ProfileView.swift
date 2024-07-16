//
//  ProfileView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            
            VStack(spacing: 20) {
                
                ProfileHeaderView(user: user)
                
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 32)
                        .background(.black)
                        .cornerRadius(8)
                }
                
                UserContentListView(user: user)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        
    }
}

#Preview {
    ProfileView(user: User(id: NSUUID().uuidString, fullname: "Max Moro", email: "max@gmail.com", username: "maxmoro1", bio: ""))
}
