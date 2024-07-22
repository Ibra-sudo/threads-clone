//
//  ComponentsViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 17.07.24.
//

import Foundation
import Firebase

class ComponentsViewModel: ObservableObject {
    
    @Published var threads = [Thread]()
    @Published var comments = [Comment]()
    
    init() {
        Task { try await fetchUserThreads() }
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.threads = try await ThreadService.fetchUserThreads(uid: uid)
    }
    
    @MainActor
    func deleteThread(thread: Thread) async throws {
        try await ThreadService.deleteUserThread(uid: thread.id)
        if let index = threads.firstIndex(where: { $0.id == thread.id}) {
            threads.remove(at: index)
        }
    }
    
    @MainActor
    func likeThread(thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await ThreadService.likeUserThread(thread: thread, uid: uid)
        if let index = threads.firstIndex(where: { $0.id == thread.id }) {
            threads[index].likes.append(uid)
        }
    }
    
    @MainActor
    func unlikeThread(thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await ThreadService.unlikeUserThread(thread: thread, uid: uid)
        if let index = threads.firstIndex(where: { $0.id == thread.id }),
           let likeIndex = threads[index].likes.firstIndex(of: uid) {
            threads[index].likes.remove(at: likeIndex)
        }
    }
    
    @MainActor
    func fetchThreadsWithUserComments() async throws {
        
        do {
            self.comments = try await ThreadService.fetchComments()
        } catch {
            print("error fetching comments")
        }
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        self.threads = try await ThreadService.fetchThreadsWithUserComments(uid: uid)
    }
    
}
