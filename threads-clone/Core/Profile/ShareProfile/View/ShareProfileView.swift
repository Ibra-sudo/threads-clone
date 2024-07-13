//
//  ShareProfileView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 12.07.24.
//

import SwiftUI

struct ShareProfileView: View {
    
    @State private var link = ""
    @State private var isPrivateProfile = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("emojis")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                
                VStack {
                    
                    HStack {
                        Spacer()
                        VStack {
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                            }
                            .overlay {
                                Circle()
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                                    .frame(width: 70, height: 70)
                            }
                            .padding()
                            
                            Text("Share profile")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button {
                                
                            } label: {
                                Image(systemName: "doc.on.doc")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                            }
                            .overlay {
                                Circle()
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                                    .frame(width: 70, height: 70)
                            }
                            .padding()
                            
                            Text("Copy link")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        
                        VStack {
                            Button {
                                
                            } label: {
                                Image(systemName: "arrow.down.circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.black)
                                    
                            }
                            .overlay {
                                Circle()
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                                    .frame(width: 70, height: 70)
                            }
                            .padding()
                            
                            Text("Download")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 150)
                    .frame(maxWidth: .infinity)
                }
                .font(.footnote)
                .padding()
                .background(.white)
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
                    .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    ShareProfileView()
}
