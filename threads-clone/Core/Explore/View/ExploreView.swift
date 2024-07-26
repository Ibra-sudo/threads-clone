//
//  ExploreView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI
import Firebase

struct ExploreView: View {
    
    let comment: Comment
    
    @StateObject var viewModel = ExploreViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack{
                    ForEach(viewModel.filteredUsers) { user in
                        NavigationLink (value: user) {
                            VStack {
                                
                                UserCell(user: user)
                                
                                Divider()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user, comment: comment)
            })
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
                .autocapitalization(.none)
        }
    }
}

//#Preview {
//    ExploreView()
//}
struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(comment: dev.comment)
    }
}
