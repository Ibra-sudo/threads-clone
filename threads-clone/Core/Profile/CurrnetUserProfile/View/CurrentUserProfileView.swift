//
//  CurrentUserProfileView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 12.07.24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
    @State private var shareProfile = false
    
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
                                .foregroundColor(.black)
                                .frame(width: 175, height: 32)
                                .background(.white)
                                .cornerRadius(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                }
                        }
                        
                        Button {
                            shareProfile.toggle()
                        } label: {
                            Text("Share Profile")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(width: 175, height: 32)
                                .background(.white)
                                .cornerRadius(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                }
                        }
                    }
                    
                    if let user = currentUser {
                        UserContentListView(user: user)
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
                    .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
