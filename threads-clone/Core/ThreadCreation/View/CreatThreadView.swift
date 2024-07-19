//
//  CreatThreadView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI

struct CreatThreadView: View {
    
    @StateObject var viewModel = CreateThreadViewModel()
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    private let characterLimit = 550
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack {
                    HStack(alignment: .top){
                        
                        HStack(alignment: .top) {
                            
                            VStack(alignment: .leading) {
                                CircularProfileImageView(user: user, size: .small)
                            }
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user?.username ?? "")
                                .fontWeight(.semibold)
                            
                            TextField("Start a thread...", text: $caption, axis: .vertical)
                                .onChange(of: caption) { oldValue, newValue in
                                    if newValue.count > characterLimit {
                                        caption = String(newValue.prefix(900))
                                    }
                                }
                        }
                        .font(.footnote)
                        Spacer()
                        
                        if !caption.isEmpty {
                            Button {
                                caption = ""
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("New Thread")
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
                        Text("\(characterLimit - caption.count)")
                            .font(.footnote)
                            .foregroundColor((characterLimit - caption.count) < 0 ? .red : .gray)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Post") {
                            Task{ try await viewModel.uploadThread(caption: caption)
                                dismiss()
                            }
                        }
                        .opacity(caption.isEmpty || caption.count > characterLimit ? 0.5 : 1.0)
                        .disabled(caption.isEmpty || caption.count > characterLimit)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    CreatThreadView()
}
