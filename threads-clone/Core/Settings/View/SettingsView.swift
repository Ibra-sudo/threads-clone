//
//  SettingsView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 16.07.24.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 17) {
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "bell")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                            Text("Notifications")
                                .font(.subheadline)
                                .fontWeight(.semibold)
//                                .foregroundStyle(.black)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "lock")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                            Text("Privacy")
                                .font(.subheadline)
                                .fontWeight(.semibold)
//                                .foregroundStyle(.black)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "person.circle")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                            Text("Account")
                                .font(.subheadline)
                                .fontWeight(.semibold)
//                                .foregroundStyle(.black)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                            Text("Help")
                                .font(.subheadline)
                                .fontWeight(.semibold)
//                                .foregroundStyle(.black)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "exclamationmark.circle")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                            Text("About")
                                .font(.subheadline)
                                .fontWeight(.semibold)
//                                .foregroundStyle(.black)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Divider()
//                        .background(colorScheme == .dark ? Color.white : Color.black)
                    
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Text("Log Out")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.primary)
                }
                .padding(.vertical, 12)
            }
            .padding(.horizontal, 20)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
        }
        
    }
}

#Preview {
    SettingsView()
}
