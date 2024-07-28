//
//  UserContentListViewModel.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 16.07.24.
//

import Combine
import Firebase
import FirebaseFirestoreSwift

class UserContentListViewModel: ObservableObject {
    
    @Published var threads = [Thread]()
    @Published var comments = [Comment]()
    @Published var threadCommentPairs = [ThreadCommentPair]()
    @Published var repostThreads = [Repost]()
    
    let user: User
    let comment: Comment
    private var threadListener: ListenerRegistration?
    private var commentListener: ListenerRegistration?
    
    init(user: User, comment: Comment) {
        self.user = user
        self.comment = comment
        fetchInitialData()
        setupListeners()
    }
    
    private func fetchInitialData() {
        Task {
            try await fetchUserThreads()
            try await fetchThreadsWithComments()
        }
    }
    
    private func setupListeners() {
        let db = Firestore.firestore()
        
        threadListener = db.collection("threads").addSnapshotListener { [weak self] (snapshot, error) in
            guard let self = self else { return }
            if let snapshot = snapshot {
                for diff in snapshot.documentChanges {
                    switch diff.type {
                    case .added, .modified, .removed:
                        Task {
                            try await self.fetchUserThreads()
                        }
                    }
                }
            }
        }
        
        commentListener = db.collection("comments").addSnapshotListener { [weak self] (snapshot, error) in
            guard let self = self else { return }
            if let snapshot = snapshot {
                for diff in snapshot.documentChanges {
                    switch diff.type {
                    case .added, .modified, .removed:
                        Task {
                            try await self.fetchThreadsWithComments()
                        }
                    }
                }
            }
        }
    }
    
    
    deinit {
        threadListener?.remove()
        commentListener?.remove()
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        var threads = try await ThreadService.fetchUserThreads(uid: user.id)
        
        for i in 0 ..< threads.count {
            threads[i].user = self.user
        }
        self.threads = threads
    }
    
    @MainActor
    func fetchThreadsWithComments() async throws {
        var pairs = try await ThreadService.fetchThreadsWithComments(uid: user.id)
        
        for index in 0 ..< pairs.count {
            for commentIndex in 0 ..< pairs[index].comments.count {
                pairs[index].comments[commentIndex].user = self.user
            }
        }
        
        self.threadCommentPairs = pairs
        self.comments = pairs.flatMap { $0.comments }
    }
    
//    @MainActor
//    func fetchRepostThreads() async throws {
//        var repostthreads = try await ThreadService.fetchRepostThreads(uid: user.id)
//        
//        for i in 0 ..< repostthreads.count {
//            repostthreads[i].user = self.user
//        }
//        self.repostThreads = repostthreads
//    }
}
