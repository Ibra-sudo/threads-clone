//
//  EditProfileView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 10.07.24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    let user: User
    
    @Environment(\.colorScheme) var colorScheme
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivateProfile = false
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                
                VStack {
                    // name and profile image
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .fontWeight(.semibold)
                            
                            Text(user.fullname)
                        }
                        .font(.footnote)
                        
                        Spacer()
                        
                        PhotosPicker(selection: $viewModel.selectedItem) {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle()
                                            .stroke(Color(.systemGray2), lineWidth: 1)
                                    }
                            } else {
                                CircularProfileImageView(user: user, size: .small)
                                    .overlay {
                                        Circle()
                                            .stroke(Color(.systemGray2), lineWidth: 1)
                                    }
                            }
                                
                        }
                        
                    }
                    
                    Divider()
                    
                    // bio field
                    VStack(alignment: .leading) {
                        Text("Bio")
                            .fontWeight(.semibold)
                        
                        TextField("+ Write your bio...", text: $bio, axis: .vertical)
                    }
                    .font(.footnote)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Link")
                            .fontWeight(.semibold)
                        
                        TextField("+ Add link...", text: $link)
                    }
                    .font(.footnote)
                    
                    Divider()
                    
                    Toggle(isOn: $isPrivateProfile) {
                        Text("Private Profile")
                            .fontWeight(.semibold)
                        if isPrivateProfile {
                            Text("Private profiles can only reply to their followers. Switch to public to replay to anyone.")
                                .font(.footnote)
                                .fontWeight(.thin)
                        } else {
                            Text("If you switch to private, you won't be able to replay to others unless they follow you.")
                                .font(.footnote)
                                .fontWeight(.thin)
                        }
                        
                    }
                    .tint(colorScheme == .dark ? Color(.darkGray) : Color.black)
//                    .tint(colorScheme == .light ? Color.white : Color.black)
                }
                .font(.footnote)
                .padding()
                .background(colorScheme == .light ? Color.white : Color.black)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                .padding()
                
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.primary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        Task { try await viewModel.updateUserData()
                            dismiss()
                        }
                    }
                    .opacity(viewModel.profileImage == nil && bio.isEmpty && link.isEmpty && !isPrivateProfile ? 0.5 : 1.0)
                    .disabled(viewModel.profileImage == nil && bio.isEmpty && link.isEmpty && !isPrivateProfile)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview {
    EditProfileView(user: User(id: NSUUID().uuidString, fullname: "", email: "", username: "", profileImageUrl: "", bio: ""))
}
