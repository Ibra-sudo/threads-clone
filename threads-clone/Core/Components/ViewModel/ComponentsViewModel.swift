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
}
