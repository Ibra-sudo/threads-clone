//
//  UserContentListViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 16.07.24.
//

import Foundation

class UserContentListViewModel: ObservableObject {
    
    @Published var threads = [Thread]()
    
    var user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserThreads() }
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        var threads = try await ThreadService.fetchUserThreads(uid: user.id)
        
        for i in 0 ..< threads.count {
            threads[i].user = self.user
        }
        self.threads = threads
    }
    
//    @MainActor
//    func fetchComments() async throws {
//        var comments = try await ThreadService.fetchComments()
//        
//        for i in 0 ..< threads.count {
//            threads[i].user = self.user
//        }
//        self.threads = threads
//    }
}
