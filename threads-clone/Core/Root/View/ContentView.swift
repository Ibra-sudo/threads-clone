//
//  ContentView.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 09.07.24.
//

import SwiftUI

struct ContentView: View {
    
    let user: User
    let comment: Comment
    
    @StateObject var viewModel = ContenetViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ThreadsTabView(user: user, comment: comment)
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: dev.user, comment: dev.comment)
    }
}
