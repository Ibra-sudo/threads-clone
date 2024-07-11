//
//  ThreadsTabView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI

struct ThreadsTabView: View {
    
    @State private var selectedTab = 0
    @State private var previousSelectedTap = 0
    @State private var showCreateThreadView = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack{
                FeedView()
            }
            .tabItem {
                Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
            }
//            .onAppear {
//                selectedTab = 0
//            }
            .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
//                .onAppear {
//                    selectedTab = 1
//                }
                .tag(1)
            
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }
//                .onAppear {
//                    selectedTab = 2
//                }
                .tag(2)
            
            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
//                .onAppear {
//                    selectedTab = 3
//                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
//                .onAppear {
//                    selectedTab = 4
//                }
                .tag(4)
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            if newValue == 2 {
                previousSelectedTap = oldValue
                showCreateThreadView = true
            }
//            showCreateThreadView = selectedTab == 2
        }
        .sheet(isPresented: $showCreateThreadView, onDismiss: {
            selectedTab = previousSelectedTap
        }, content: {
            CreatThreadView()
        })
        .tint(.black)
    }
}

#Preview {
    ThreadsTabView()
}

