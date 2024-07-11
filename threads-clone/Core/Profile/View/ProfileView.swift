//
//  ProfileView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    // to resizable width of the phone screen
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 16
    }
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                
                VStack(spacing: 20) {
                    HStack(alignment: .top){
                        
                        // bio and stats
                        VStack(alignment: .leading, spacing: 12) {
                            
                            // fullname and username
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Charles Leclerc")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text("charles_leclerc")
                                    .font(.subheadline)
                            }
                            
                            Text("HR management and sales marketing")
                                .font(.footnote)
                            
                            Text("4 followers")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        CircularProfileImageView()
                    }
                    
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
                    
                    // user content list view
                    VStack {
                        HStack {
                            ForEach(ProfileThreadFilter.allCases) { filter in
                                VStack {
                                    Text(filter.title)
                                        .font(.subheadline)
                                        .fontWeight(selectedFilter == filter ? .semibold : .regular)
                                    
                                    if selectedFilter == filter {
                                        Rectangle()
                                            .foregroundColor(.black)
                                            .frame(width: filterBarWidth, height: 1)
                                            .matchedGeometryEffect(id: "item", in: animation) // to make move on as smothy animation and we need property name: Namespace to do this animation
                                    } else {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: filterBarWidth, height: 1)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedFilter = filter
                                    }
                                }
                            }
                        }
                        LazyVStack {
                            ForEach(0 ... 10, id: \.self) { thread in
                                ThreadCell()
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
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
    ProfileView()
}
