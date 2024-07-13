//
//  ProfileHeaderView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 12.07.24.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    let user: User?
    
    init(user: User?) {
        self.user = user
    }
    var body: some View {
        HStack(alignment: .top){
            
            // bio and stats
            VStack(alignment: .leading, spacing: 12) {
                
                // fullname and username
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.fullname ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(user?.username ?? "")
                        .font(.subheadline)
                }
                
                if let bio = user?.bio {
                    Text(bio)
                        .font(.footnote)
                }
                
                Text("4 followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            CircularProfileImageView()
        }
    }
}

#Preview {
    ProfileHeaderView(user: User(id: NSUUID().uuidString, fullname: "Max Moro", email: "max@gmail.com", username: "maxmoro1", bio: ""))
}
