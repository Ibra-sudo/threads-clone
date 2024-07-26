//
//  CurrentUserProfileView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 12.07.24.
//

import SwiftUI
import Firebase

struct CurrentUserProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
    @State private var shareProfile = false
    
    let comment: Comment
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                
                VStack(spacing: 20) {
                    
                    ProfileHeaderView(user: currentUser)
                    
                    HStack {
                        
                        Button {
                            showEditProfile.toggle()
                        } label: {
                            Text("Edit Profile")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                .frame(width: 175, height: 32)
                                .background(colorScheme == .light ? Color.white : Color.black)
                                .cornerRadius(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray3), lineWidth: 1)
                                }
                        }
                        
                        Button {
                            shareProfile.toggle()
                        } label: {
                            Text("Share Profile")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                .frame(width: 175, height: 32)
                                .background(colorScheme == .light ? Color.white : Color.black)
                                .cornerRadius(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray3), lineWidth: 1)
                                }
                        }
                    }
                    
                    if let user = currentUser {
                        UserContentListView(user: user, comment: comment)
                    }
                }
            }
            .sheet(isPresented: $showEditProfile, content: {
                if let user = currentUser {
                    EditProfileView(user: user)
                }
            })
            .sheet(isPresented: $shareProfile, content: {
                ShareProfileView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "line.3.horizontal")
                    }
                    .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
        }
    }
}

//#Preview {
//    CurrentUserProfileView()
//}
struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(comment: dev.comment)
    }
}
