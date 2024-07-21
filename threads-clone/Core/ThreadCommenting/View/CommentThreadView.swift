//
//  CommentThreadView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 20.07.24.
//

import SwiftUI
import Firebase

struct CommentThreadView: View {
    
    @StateObject var viewModel = CommentThreadViewModel()
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
    
    let thread: Thread
    
    // to resizable height of a Rectangle
    private func calculateHeight() -> CGFloat {
        let textHeight = caption.height(withConstrainedWidth: UIScreen.main.bounds.width - 60, font: UIFont.systemFont(ofSize: 14))
        return textHeight + 30
    }
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    private let characterLimit = 550
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                ReplayThreadCell(thread: thread)
                
                HStack(alignment: .top, spacing: 12){
                    
                    VStack {
                        CircularProfileImageView(user: user, size: .small)

                        Rectangle()
                            .frame(width: 1.6, height: calculateHeight())
                            .foregroundColor(Color(.systemGray4))
                            .padding(.vertical, 4)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user?.username ?? "")
                            .fontWeight(.semibold)
                        
                        TextField("Start a thread...", text: $caption, axis: .vertical)
                            .onChange(of: caption) { oldValue, newValue in
                                if newValue.count > characterLimit {
                                    caption = String(newValue.prefix(620))
                                }
                            }
                        
                        HStack(spacing: 20) {
                            Button {
                                
                            } label: {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .resizable()
                                    .modifier(ThreadCreateModifier())
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "camera")
                                    .resizable()
                                    .modifier(ThreadCreateModifier())
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "text.bubble")
                                    .resizable()
                                    .modifier(ThreadCreateModifier())
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "mic")
                                    .resizable()
                                    .frame(width: 14, height: 18)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "number")
                                    .resizable()
                                    .modifier(ThreadCreateModifier())
                            }
                        }
                        .foregroundColor(.gray)
                        .padding(.top, 23)
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
                
                HStack {
                    if caption.isEmpty {
                        CircularProfileImageView(user: user, size: .xxSmall)
                            .opacity(0.4)
                    
                        Text("   Add to thread")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .opacity(0.4)
                    } else {
                        CircularProfileImageView(user: user, size: .xxSmall)
                            .opacity(1.0)
                        
                        Text("   Add to thread")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .opacity(1.0)
                    }
                }
                .padding(.horizontal, 8)
                Spacer()
                

            }
            .padding()
            .navigationTitle("Reply Thread")
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
                        .opacity((characterLimit - caption.count) <= 50 ? 1.0 : 0.0)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        Task{ try await viewModel.uploadComment(thread: thread, caption: caption)
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

struct CommentThreadView_Previews: PreviewProvider {
    static var previews: some View {
        CommentThreadView(thread: dev.thread)
    }
}
