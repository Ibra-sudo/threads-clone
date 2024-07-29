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
    @Published var userComments = [Comment]()
    @Published var threadCommentPairs = [ThreadCommentPair]()
    @Published var likesDictionary = [String: [String]]()
    @Published var repostThreads = [Repost]()
    
    private var listener: ListenerRegistration?
    
    init() {
        Task { try await fetchUserThreads() }
        setupListener()
    }
    
    func setupListener() {
        listener = Firestore.firestore().collection("threads").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            
            self.threads = documents.compactMap { try?$0.data(as: Thread.self) }
        }
    }
    
    deinit {
        listener?.remove()
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
    
//    @MainActor
//    func fetchLikes() async throws {
//        likesDictionary = try await ThreadService.fetchLikesForThreads()
//    }
    
    @MainActor
    func fetchThreadsWithUserComments(thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.userComments = thread.comments.filter { $0.ownerUid == uid }
    }
    
    @MainActor
    func repostThread(thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await ThreadService.repostThread(thread: thread, uid: uid)
        if let index = threads.firstIndex(where: { $0.id == thread.id }) {
            threads[index].repostedBy.append(uid)
        }
    }
    
    @MainActor
    func unrepostThread(thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await ThreadService.unrepostThread(thread: thread, uid: uid)
        if let index = threads.firstIndex(where: { $0.id == thread.id }),
           let repostIndex = threads[index].repostedBy.firstIndex(of: uid) {
            threads[index].repostedBy.remove(at: repostIndex)
        }
    }
    
//    @MainActor
//    func fetchRepostThreads() async throws {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        repostThreads = try await ThreadService.fetchRepostThreads(uid: uid)
//    }
    
}
